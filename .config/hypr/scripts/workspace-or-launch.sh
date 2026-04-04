#!/usr/bin/env bash
# Usage: workspace-or-launch.sh <workspace> <initial_title> <app> [args...]

WORKSPACE="$1"
INITIAL_TITLE="$2"
shift 2
APP="$@"

# Always switch to the workspace first
hyprctl dispatch focusworkspaceoncurrentmonitor "name:$WORKSPACE"

# Check if workspace has a window with the expected initial title
if ! hyprctl clients -j | jq -e ".[] | select(.workspace.name == \"$WORKSPACE\" and .initialTitle == \"$INITIAL_TITLE\")" > /dev/null 2>&1; then
    $APP &
fi
