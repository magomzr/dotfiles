_header() {
  local CYAN='\033[0;36m'
  local RESET='\033[0m'

  echo ""
  echo -e "${CYAN}  $1 — magomzr${RESET} · $(date '+%Y-%m-%d %H:%M:%S')"
}

# Fetchs and cleans current repository, then checkouts to the new branch provided as an argument
gclean() {
  local target_branch="${1:-$(git branch --show-current || echo 'main')}"
  local current_branch
  local tmp_branch="cleanup/$$"

  # Colors
  local GREEN='\033[0;32m'
  local CYAN='\033[0;36m'
  local RED='\033[0;31m'
  local RESET='\033[0m'

  # Header
  _header "gclean"
  echo -e "  target: ${GREEN}$target_branch${RESET}"
  echo ""

  # Check if we are in a repo
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "  ${RED}✗${RESET} not in a git repository."
    return 1
  fi

  current_branch=$(git branch --show-current)

  # Check for pending changes
  local pending
  pending=$(git status -s)
  if [ -n "$pending" ]; then
    echo -e "  ${RED}!${RESET} you have uncommitted changes:\n"
    echo "$pending" | sed 's/^/    /'
    echo ""
    printf "  discard them and continue? [Y/n] "
    read -r answer
    if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
      git checkout . 2>/dev/null
      git clean -fd 2>/dev/null
    else
      echo -e "  ${RED}✗${RESET} save your work first, then try again."
      return 1
    fi
  fi

  # Handle existing tmp branch
  while git show-ref --verify --quiet "refs/heads/$tmp_branch"; do
    local counter=$((${tmp_branch##*/} + 1))
    echo -e "  ${CYAN}!${RESET} branch '$tmp_branch' exists, creating cleanup/$counter instead."
    tmp_branch="cleanup/$counter"
  done

  # Jump to tmp branch
  echo -e "  ${CYAN}→${RESET} jumping to temp branch '$tmp_branch'..."
  git checkout -b "$tmp_branch" || return 1

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
  git branch -D "$tmp_branch"

  echo ""
  echo -e "  ${GREEN}✓ done.${RESET}"
  echo ""
}

# Creates a new branch using the "git checkout -b" command
gcb() {
  # Header
  _header "gcb"

  local branch_name="$1"

  if [ -z "$branch_name" ]; then
    echo -e "  ${RED}✗${RESET} please provide a branch name."
    return 1
  fi

  git checkout -b "$branch_name"
}

# Ammends to previous commit without edition
gcam() {
  # Header
  _header "gcam"

  git commit --ammend --no-edit || return 1
}

# Pushes the current branch to the remote repository
gpoc() {
  local current_branch="$(git branch --show-current)" || return 1

  git push origin "$current_branch" || return 1
}
