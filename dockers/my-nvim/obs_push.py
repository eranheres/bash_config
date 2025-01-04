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
    Checks if the Git repository has been modified locally.
    """
    output, _ = run_command("git status --porcelain")
    return len(output) > 0

def commit_changes():
    """
    Commits local changes to the repository.
    """
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    commit_message = f"Auto commit on {current_time}"
    run_command("git add .")
    run_command(f"git commit -m \"{commit_message}\"")
    print("Local changes committed.")

def pull_and_merge():
    """
    Pulls the latest changes from the remote repository and merges them.
    If conflicts occur, resolves them by accepting remote changes.
    """
    _, returncode = run_command("git pull --no-rebase")
    if returncode != 0:
        print("Conflicts detected. Resolving by accepting remote changes...")
        run_command("git checkout --theirs .")
        run_command("git add .")
        run_command("git commit -m \"Resolved conflicts by accepting remote changes\"")
    print("Remote changes pulled and merged.")

def push_changes():
    """
    Pushes local changes to the remote repository.
    """
    run_command("git push")
    print("Local changes pushed to remote repository.")

def is_remote_updated():
    """
    Checks if the remote repository has updates.
    """
    run_command("git fetch")
    local_hash, _ = run_command("git rev-parse HEAD")
    remote_hash, _ = run_command("git rev-parse @{u}")
    return local_hash != remote_hash

def main():
    # Get the path to the Git repository from command line arguments
    if len(sys.argv) < 2:
        print("Usage: python script.py /path/to/your/repository")
        sys.exit(1)
    
    repo_path = sys.argv[1]
    os.chdir(repo_path)

    local_changed = is_repo_modified()
    remote_updated = is_remote_updated()

    if local_changed:
        commit_changes()

    if remote_updated:
        pull_and_merge()

    if local_changed:
        push_changes()
    else:
        print("No changes detected locally or remotely. Nothing to commit or push.")

if __name__ == "__main__":
    main()
