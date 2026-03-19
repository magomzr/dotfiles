gclean() {
  local target_branch="${1:-main}"
  local current_branch
  local created_tmp=false
  local tmp_branch="cleanup/$$"

  # Colors
  local GREEN='\033[0;32m'
  local CYAN='\033[0;36m'
  local RED='\033[0;31m'
  local RESET='\033[0m'

  # Header
  echo ""
  echo -e "${CYAN}  gclean — magomzr${RESET}"
  echo -e "  target: ${GREEN}$target_branch${RESET} · $(date '+%Y-%m-%d %H:%M:%S')"
  echo ""

  current_branch=$(git branch --show-current)

  # Check if we are in a repo
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "  ${RED}✗${RESET} not in a git repository."
    return 1
  fi

  # Jump to tmp branch if not already on target
  if [[ "$current_branch" != "$target_branch" ]]; then
    echo -e "  ${CYAN}→${RESET} jumping to temp branch '$tmp_branch'..."
    git checkout -b "$tmp_branch" || return 1
    created_tmp=true
  else
    echo -e "  ${CYAN}→${RESET} already on '$target_branch', cleaning..."
  fi

  # Fetch with prune option
  echo -e "  ${CYAN}→${RESET} fetching..."
  git fetch -p || return 1

  # Delete all local branches except current one
  echo -e "  ${CYAN}→${RESET} deleting local branches..."
  git branch \
    | grep -v '^\*' \
    | xargs -r git branch -D

  # Checkout target branch, fresh from remote
  echo -e "  ${CYAN}→${RESET} checking out '$target_branch' from remote..."
  git checkout "$target_branch" || return 1

  # Delete tmp branch
  if [[ "$created_tmp" == true ]]; then
    git branch -D "$tmp_branch"
  fi

  echo ""
  echo -e "  ${GREEN}✓ done.${RESET}"
  echo ""
}
