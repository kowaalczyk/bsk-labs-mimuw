import argparse

from bsk_utils.common import run_cmd
from bsk_utils.user_management import read_ids


parser = argparse.ArgumentParser()
parser.add_argument('-l', '--students-list', type=str, required=True)


if __name__ == '__main__':
    args = parser.parse_args()
    student_ids = read_ids(args.students_list)
    
    # check if the user knows what he's doing
    print('clean will do the following:')
    for dirname in ['documents', 'tasks', 'solutions']:
        print(f"remove {dirname} and all its contents permanently")
    for username in student_ids:
        print(f"remove user {username}")
    user_in = input('Proceed? [yes/no]')
    if user_in == 'yes':
        # perform cleanup
        for dirname in ['documents', 'tasks', 'solutions']:
            try:
                run_cmd('rm', '-rf', dirname)
            except Exception as e:
                print(f"Error deleting {dirname}:", e)
        for username in student_ids:
            try:
                run_cmd('userdel', '-r', username)
            except Exception as e:
                print(f"Error deleting {username}:", e)
        print('Done!')
    else:
        print('Aborted.')