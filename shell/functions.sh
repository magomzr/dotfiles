gclean() {
  local target_branch="${1:-main}"
  local current_branch
  local created_tmp=false
  local tmp_branch="tmp/cleanup-$$"

  current_branch=$(git branch --show-current)

  # Check if we are in a repo
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "not in a git repository."
  fi

  # Jump to tmp branch if not already on target
  if [[ "$current_branch" != "$target_branch" ]]; then
    echo "jumping to temp branch '$tmp_branch'..."
    git checkout -b "$tmp_branch" || return 1
    created_tmp=true
  else
    echo "already on '$target_branch', cleaning..."
  fi

  # Fetch with prune option
  echo "fetching..."
  git fetch -p || return 1

  # Delete all local branches except current one
  echo "deleting local branches..."
  git branch \
    | grep -v '^\*' \
    | xargs -r git branch -D

  # Checkout target branch, fresh from remote
  echo "checking out '$target_branch' from remote..."

  # Delete tmp branch
  if [[ "$created_tmp" == true ]]; then
    git branch -D "$tmp_branch"
  fi
}

