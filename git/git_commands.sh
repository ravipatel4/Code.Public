# Git commands from https://www.youtube.com/watch?v=FyAAIHHClqI

# Create an empty repo
git init

# Check the status
git status

# Add the changes to staging area
git add 

# Commit the changes
git commit -m "message"

# Push the changes
git push

# Pull the changes
git pull

# Show the commit history of the repo
git log --all --decorate --oneline --graph

# List branches
git branch

# Create a branch
git branch <branch name>

# Checkout a branch / a commit
git checkout <branch name / commit sha id(7 letters)>

# To list the differences between two branches
git diff <branch1 name>..<branch2 name>

# Merge the current branch with the <branch name>. 
# Fast Forward merge, if there is a straight path between the two branches.
# Three-way merge, if there is not a straight path between the branches. The following command will merge the changes made to both branches as long as the changes are not made on the same line in both branches. If they are, git aborts a merge, gives a warning message and adds git markups in the file to indicate the conflicts.
git merge <branch name>

# Show the branches that are merged
git branch --merged

# Delete a branch
git branch -d <branch name>

# Delete a branch forcefully.
git branch -D <branch name>

# Delete a remote branch from the command prompt
git push origin --delete <branch name>

# Create and checkout the branch.
git checkout -b <branch name>

# Show the changes in the current branch
git diff

# Stage the changes and commit in a single command.
get commit -a -m "message"

# Abort the merge: useful when there are conflicts in the merge and the merge hasn't gone through, but the conflicted file has the git markups.
git merge --abort

# Save the changes to stash if you want to checkout another branch before comming the changes made in the current branch.
git stash

# Save the stash along with a useful message to associate with the stash.
git stash save "message"

# List stashes
git stash list

# Observe the edits at each stash point
git stash list -p 

# Reapply the most recent stash (for the commit). This doesn't remove the stashes from the list.
git stash apply

# Reapply the most recent stash and also remove from the list.
git stash pop

# To use a different stash (not the most recent)
git stash apply <stash label>
