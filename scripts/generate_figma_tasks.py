#!/usr/bin/env python3
"""
Figma Task Extractor — Generate feature task files from a Figma file.

Usage:
  python scripts/generate_figma_tasks.py "<FIGMA_URL>" [--token TOKEN] [--output-dir DIR]

Examples:
  python scripts/generate_figma_tasks.py "https://figma.com/design/ABC123/MyApp?node-id=0-1"
  python scripts/generate_figma_tasks.py "https://figma.com/design/ABC123/MyApp" --token figd_xxx

Environment:
  FIGMA_ACCESS_TOKEN — Your Figma personal access token (or use --token flag)

Output:
  .cursor/prompt/tasks/{feature_name}.md  — One task file per screen
  .cursor/prompt/tasks/_schedule.md       — Master schedule with all tasks
"""

import argparse
import json
import os
import re
import sys
import urllib.request
import urllib.error
from datetime import datetime
from pathlib import Path


def parse_figma_url(url: str) -> dict:
    """Extract fileKey, fileName, and nodeId from a Figma URL."""
    patterns = [
        # Branch URL: /design/:fileKey/branch/:branchKey/:fileName
        r'figma\.com/design/([^/]+)/branch/([^/]+)/([^?]+)',
        # Standard URL: /design/:fileKey/:fileName?node-id=X-Y
        r'figma\.com/design/([^/]+)/([^?]+)',
        # File URL: /file/:fileKey/:fileName
        r'figma\.com/file/([^/]+)/([^?]+)',
    ]

    file_key = None
    file_name = None

    for i, pattern in enumerate(patterns):
        match = re.search(pattern, url)
        if match:
            if i == 0:  # branch URL
                file_key = match.group(2)  # use branchKey
                file_name = match.group(3)
            else:
                file_key = match.group(1)
                file_name = match.group(2)
            break

    if not file_key:
        raise ValueError(f"Could not extract fileKey from URL: {url}")

    node_id = None
    node_match = re.search(r'node-id=([^&]+)', url)
    if node_match:
        node_id = node_match.group(1).replace('-', ':')

    file_name = file_name.split('?')[0] if file_name else 'Untitled'
    file_name = urllib.request.unquote(file_name).replace('-', ' ')

    return {
        'file_key': file_key,
        'file_name': file_name,
        'node_id': node_id,
    }


def fetch_figma_file(file_key: str, token: str, node_id: str = None, depth: int = 2) -> dict:
    """Fetch file structure from Figma REST API."""
    base_url = f"https://api.figma.com/v1/files/{file_key}"

    params = []
    if depth:
        params.append(f"depth={depth}")
    if node_id:
        params.append(f"ids={node_id}")

    url = base_url
    if params:
        url += '?' + '&'.join(params)

    req = urllib.request.Request(url, headers={'X-Figma-Token': token})

    try:
        with urllib.request.urlopen(req) as response:
            return json.loads(response.read().decode())
    except urllib.error.HTTPError as e:
        if e.code == 403:
            print("ERROR: Invalid or expired Figma token.", file=sys.stderr)
            print("Get a token from: https://www.figma.com/developers/api#access-tokens", file=sys.stderr)
        elif e.code == 404:
            print(f"ERROR: File not found. Check the URL/fileKey: {file_key}", file=sys.stderr)
        else:
            print(f"ERROR: Figma API returned {e.code}: {e.read().decode()}", file=sys.stderr)
        sys.exit(1)


def extract_screens(figma_data: dict, file_key: str) -> list:
    """Extract top-level frames (screens) from Figma file data."""
    screens = []

    document = figma_data.get('document', {})

    for page in document.get('children', []):
        if page.get('type') != 'CANVAS':
            continue

        page_name = page.get('name', 'Page')

        for node in page.get('children', []):
            node_type = node.get('type', '')
            node_name = node.get('name', 'Untitled')
            node_id = node.get('id', '')

            if node_type != 'FRAME' and node_type != 'SECTION':
                continue

            if node_type == 'SECTION':
                for child in node.get('children', []):
                    if child.get('type') == 'FRAME':
                        _process_frame(child, page_name, file_key, screens)
                continue

            _process_frame(node, page_name, file_key, screens)

    return screens


EXCLUDED_NAMES = {
    'components', 'icons', 'styles', 'design system', 'tokens',
    'colors', 'typography', 'assets', 'symbols', 'variants',
    'cover', 'thumbnail', 'readme',
}

# Min frame size to count as screen (matches figma-task-extractor skill: 300x500)
MIN_FRAME_WIDTH = 300
MIN_FRAME_HEIGHT = 500


def _process_frame(node: dict, page_name: str, file_key: str, screens: list):
    """Process a single frame node and add to screens if it's a valid screen."""
    node_name = node.get('name', 'Untitled')
    node_id = node.get('id', '')

    if node_name.startswith('.') or node_name.startswith('_'):
        return

    if node_name.lower().strip() in EXCLUDED_NAMES:
        return

    bbox = node.get('absoluteBoundingBox', {})
    width = bbox.get('width', 0)
    height = bbox.get('height', 0)

    if width < MIN_FRAME_WIDTH or height < MIN_FRAME_HEIGHT:
        return

    feature_name = _to_feature_name(node_name)
    figma_node_url_id = node_id.replace(':', '-')

    screens.append({
        'screen_name': node_name,
        'feature_name': feature_name,
        'node_id': node_id,
        'figma_node_url_id': figma_node_url_id,
        'page_name': page_name,
        'width': width,
        'height': height,
    })


def _to_feature_name(name: str) -> str:
    """Convert a Figma screen name to a snake_case feature name."""
    result = name.lower()

    result = re.sub(r'[(){}[\]/#@!$%^&*+=~`|\\<>:;"\'،]', '', result)
    result = re.sub(r'[\s\-–—.]+', '_', result)
    result = re.sub(r'_+', '_', result)
    result = result.strip('_')

    if not result or not re.match(r'^[a-z]', result):
        result = 'screen_' + result

    return result


def group_screen_states(screens: list) -> list:
    """Group screens that are states of the same screen (e.g., 'Login', 'Login - Error')."""
    groups = {}

    for screen in screens:
        base_name = re.split(r'\s*[-–—]\s*|\s*\(|\s*/', screen['screen_name'])[0].strip()
        base_feature = _to_feature_name(base_name)

        if base_feature not in groups:
            groups[base_feature] = {
                'base_name': base_name,
                'feature_name': base_feature,
                'screens': [],
                'primary': None,
            }

        groups[base_feature]['screens'].append(screen)

        if screen['screen_name'].strip() == base_name:
            groups[base_feature]['primary'] = screen

    result = []
    for key, group in groups.items():
        primary = group['primary'] or group['screens'][0]
        all_nodes = [s['node_id'] for s in group['screens']]

        result.append({
            'screen_name': group['base_name'],
            'feature_name': group['feature_name'],
            'node_id': primary['node_id'],
            'figma_node_url_id': primary['figma_node_url_id'],
            'page_name': primary['page_name'],
            'width': primary['width'],
            'height': primary['height'],
            'all_states': [s['screen_name'] for s in group['screens']],
            'all_node_ids': all_nodes,
        })

    return result


def generate_task_file(screen: dict, template: str, figma_base_url: str, file_key: str) -> str:
    """Generate a task file content from the template."""
    figma_url = f"https://figma.com/design/{file_key}/?node-id={screen['figma_node_url_id']}"

    content = template.replace('[FEATURE_NAME]', screen['feature_name'])
    content = content.replace('[FIGMA_URL]', figma_url)
    content = content.replace(
        '[POSTMAN_URL] (or: لا يوجد حاليا)',
        'TODO: Add Postman URL (or: لا يوجد حاليا)'
    )

    if len(screen.get('all_states', [])) > 1:
        states_note = (
            f"\n\n> **Screen States Found in Figma:**\n"
            + '\n'.join(f"> - {s}" for s in screen['all_states'])
            + '\n'
        )
        content = content.replace(
            '---\n\nBefore writing ANY code',
            f'---{states_note}\n---\n\nBefore writing ANY code'
        )

    return content


def generate_schedule(screens: list, figma_url: str, file_key: str) -> str:
    """Generate the master schedule markdown."""
    now = datetime.now().strftime('%Y-%m-%d %H:%M')
    lines = [
        f"# Task Schedule",
        f"",
        f"Generated from: {figma_url}",
        f"Generated at: {now}",
        f"",
        f"---",
        f"",
        f"## Screens ({len(screens)} total)",
        f"",
        f"| # | Screen Name | Feature Name | Figma Node | Postman URLs | Status |",
        f"|---|---|---|---|---|---|",
    ]

    for i, s in enumerate(screens, 1):
        node_link = f"`{s['node_id']}`"
        states = f" ({len(s.get('all_states', []))} states)" if len(s.get('all_states', [])) > 1 else ""
        lines.append(
            f"| {i} | {s['screen_name']}{states} | `{s['feature_name']}` | {node_link} | TODO | ⬜ pending |"
        )

    lines.extend([
        "",
        "---",
        "",
        "## Execution Order",
        "",
        "(Adjust order as needed. Recommended: auth screens first, then main flow, then details/settings)",
        "",
    ])

    for i, s in enumerate(screens, 1):
        lines.append(f"{i}. ⬜ `{s['feature_name']}` → `.cursor/prompt/tasks/{s['feature_name']}.md`")

    lines.extend([
        "",
        "---",
        "",
        "## Navigation Map",
        "",
        "(Fill in after reviewing Figma prototype connections)",
        "",
    ])

    for s in screens:
        lines.append(f"- `{s['feature_name']}` → []")

    lines.extend([
        "",
        "---",
        "",
        "## How to Execute",
        "",
        "1. Review this schedule and adjust execution order",
        "2. Add Postman URLs to each task file that needs API services",
        "3. Fill in the Navigation Map based on Figma prototype",
        "4. Tell the AI: \"Start executing tasks\" or \"نفذ التاسك الأول\"",
        "5. After each task: AI updates status to ✅ done",
        "6. Navigation between screens is connected progressively",
        "",
        "### Commands:",
        "- \"نفذ التاسك الأول\" → Start first pending task",
        "- \"نفذ التاسك التالي\" → Continue to next pending task",
        "- \"عرض حالة التاسكات\" → Show current schedule status",
        "- \"عدل ترتيب التنفيذ\" → Modify execution order",
        "",
    ])

    return '\n'.join(lines)


def main():
    parser = argparse.ArgumentParser(
        description='Generate feature task files from a Figma file.'
    )
    parser.add_argument('url', help='Full Figma file URL')
    parser.add_argument('--token', help='Figma personal access token (or set FIGMA_ACCESS_TOKEN env var)')
    parser.add_argument('--output-dir', default='.cursor/prompt/tasks', help='Output directory for task files')
    parser.add_argument('--template', default='.cursor/prompt/feature_prompt.md', help='Path to task template')
    parser.add_argument('--no-group', action='store_true', help='Do not group screen states')
    parser.add_argument('--json', action='store_true', help='Output screen list as JSON (no file generation)')

    args = parser.parse_args()

    token = args.token or os.environ.get('FIGMA_ACCESS_TOKEN')
    if not token:
        print("ERROR: Figma access token required.", file=sys.stderr)
        print("Set FIGMA_ACCESS_TOKEN env var or use --token flag.", file=sys.stderr)
        print("Get a token: https://www.figma.com/developers/api#access-tokens", file=sys.stderr)
        sys.exit(1)

    print(f"Parsing Figma URL...")
    parsed = parse_figma_url(args.url)
    print(f"  File Key: {parsed['file_key']}")
    print(f"  File Name: {parsed['file_name']}")

    print(f"\nFetching file structure from Figma API...")
    figma_data = fetch_figma_file(parsed['file_key'], token, depth=2)

    print(f"Extracting screens...")
    screens = extract_screens(figma_data, parsed['file_key'])
    print(f"  Found {len(screens)} raw frames")

    if not args.no_group:
        screens = group_screen_states(screens)
        print(f"  After grouping states: {len(screens)} unique screens")

    if not screens:
        print("\nNo screens found! Check if the file has top-level frames.", file=sys.stderr)
        sys.exit(1)

    if args.json:
        print(json.dumps(screens, indent=2, ensure_ascii=False))
        return

    print(f"\nScreens found:")
    for i, s in enumerate(screens, 1):
        states = f" ({len(s.get('all_states', []))} states)" if len(s.get('all_states', [])) > 1 else ""
        print(f"  {i}. {s['screen_name']}{states} → {s['feature_name']} (node: {s['node_id']})")

    template_path = Path(args.template)
    if not template_path.exists():
        print(f"\nWARNING: Template not found at {template_path}", file=sys.stderr)
        print("Using minimal template.", file=sys.stderr)
        template = "Feature: [FEATURE_NAME]\nFigma Node: [FIGMA_URL]\nPostman Collection: [POSTMAN_URL] (or: لا يوجد حاليا)\n"
    else:
        template = template_path.read_text(encoding='utf-8')

    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    print(f"\nGenerating task files in {output_dir}/")
    for s in screens:
        content = generate_task_file(s, template, args.url, parsed['file_key'])
        file_path = output_dir / f"{s['feature_name']}.md"
        file_path.write_text(content, encoding='utf-8')
        print(f"  Created: {file_path}")

    schedule_content = generate_schedule(screens, args.url, parsed['file_key'])
    schedule_path = output_dir / '_schedule.md'
    schedule_path.write_text(schedule_content, encoding='utf-8')
    print(f"  Created: {schedule_path}")

    print(f"\nDone! {len(screens)} task files + 1 schedule file generated.")
    print(f"\nNext steps:")
    print(f"  1. Review: {schedule_path}")
    print(f"  2. Add Postman URLs to each task file")
    print(f"  3. Adjust execution order in schedule")
    print(f"  4. Start executing: tell the AI \"نفذ التاسك الأول\"")


if __name__ == '__main__':
    main()
