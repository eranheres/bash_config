import os
import subprocess
import sys
from datetime import datetime

git_command = "git"

if sys.platform == "darwin":
    git_command = "/opt/homebrew/bin/git"


def log_message(message):
    """
    Logs a message with the current date and time.
    """
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[{current_time}] {message}")


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
    output, _ = run_command(f"{git_command} status --porcelain")
    return len(output) > 0


def commit_changes():
    """
    Commits local changes to the repository.
    """
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    commit_message = f"Auto commit on {current_time}"
    out = run_command(f"{git_command} add .")
    print("git add out:")
    print(out)
    out = run_command(f'{git_command} commit -a -m "{commit_message}"')
    print("git commit out:")
    print(out)
    log_message("Local changes committed.")


def pull_and_merge():
    """
    Pulls the latest changes from the remote repository and merges them.
    If conflicts occur, resolves them by accepting remote changes.
    """
    out, returncode = run_command(f"{git_command} pull")
    print("pull request result:")
    print(out)
    if returncode != 0:
        log_message("Conflicts detected. Resolving by accepting remote changes...")
        run_command(f"{git_command} checkout --theirs .")
        run_command(f"{git_command} add .")
        run_command(
            f'{git_command} commit -m "Resolved conflicts by accepting remote changes"'
        )
    log_message("Remote changes pulled and merged.")


def push_changes():
    """
    Pushes local changes to the remote repository.
    """
    outp = run_command(f"{git_command} push origin main")
    print("returned from push:")
    log_message(outp)
    log_message("Local changes pushed to remote repository.")


def is_remote_updated():
    """
    Checks if the remote repository has updates.
    """
    run_command(f"{git_command} fetch")
    local_hash, _ = run_command(f"{git_command} rev-parse HEAD")
    remote_hash, _ = run_command(f"{git_command} rev-parse @" + "{u}")
    return local_hash != remote_hash


def main():
    # Get the path to the Git repository from command line arguments
    if len(sys.argv) < 2:
        log_message("Usage: python script.py /path/to/your/repository")
        sys.exit(1)

    if sys.platform == "darwin":
        print("setting git config")
        run_command(f'{git_command} config --global user.email "autocron@eran.com"')
        run_command(f'{git_command} config --global user.name "Eran Heres"')

    repo_path = sys.argv[1]
    os.chdir(repo_path)
    pwd, _ = run_command(f"{git_command} status -s")
    print("Current directory: ")
    print(pwd)
    local_changed = is_repo_modified()
    remote_updated = is_remote_updated()

    if local_changed:
        commit_changes()

    if remote_updated:
        pull_and_merge()

    if local_changed:
        push_changes()
    else:
        log_message(
            "No changes detected locally or remotely. Nothing to commit or push."
        )


if __name__ == "__main__":
    main()
