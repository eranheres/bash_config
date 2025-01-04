import os
import subprocess
import sys
from datetime import datetime

def run_command(command):
    """
    Runs a shell command and returns its output.
    """
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    return result.stdout.strip(), result.returncode

def is_repo_modified():
    """
    Checks if the Git repository has been modified.
    """
    output, _ = run_command("git status --porcelain")
    return len(output) > 0

def pull_and_rebase():
    """
    Pulls the latest changes and rebases the current branch.
    If conflicts occur, accepts remote changes.
    """
    _, returncode = run_command("git pull --rebase")
    if returncode != 0:
        print("Conflicts detected. Resolving by accepting remote changes...")
        run_command("git checkout --theirs .")
        run_command("git add .")
        run_command("git rebase --continue")

def commit_and_push_changes():
    """
    Commits and pushes changes to the remote repository.
    """
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    commit_message = f"Auto commit on {current_time}"
    
    # Add all changes
    run_command("git add .")
    
    # Commit changes
    run_command(f"git commit -m \"{commit_message}\"")
    
    # Push changes to remote repository
    run_command("git push")

def main():
    # Get the path to the Git repository from command line arguments
    if len(sys.argv) < 2:
        print("Usage: python script.py /path/to/your/repository")
        sys.exit(1)
    
    repo_path = sys.argv[1]
    os.chdir(repo_path)
    
    # Check if there are modifications
    if is_repo_modified():
        pull_and_rebase()
        commit_and_push_changes()
    else:
        print("No changes detected. Nothing to commit.")

if __name__ == "__main__":
    main()
