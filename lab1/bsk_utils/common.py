import subprocess


class SubprocessException(Exception):
    pass


def run_cmd(*args):
    cmd = subprocess.run(
        list(args), 
        stdout=subprocess.PIPE, 
        stderr=subprocess.PIPE
    )
    if not cmd.returncode == 0:
        raise SubprocessException(cmd.stderr)
    return cmd.stdout
