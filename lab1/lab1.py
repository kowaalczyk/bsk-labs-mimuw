import argparse
import os
from itertools import product

from bsk_utils.common import run_cmd
from bsk_utils.user_management import read_ids, UserGroup, setfacl


parser = argparse.ArgumentParser()
parser.add_argument('-l', '--students-list', type=str, required=True)
parser.add_argument('-f', '--friend-id', type=str, required=True)
parser.add_argument('-n', '--num-tasks', type=int, default=10)


if __name__ == '__main__':
    args = parser.parse_args()
    student_ids = read_ids(args.students_list)
    friend_id = args.friend_id

    # create top-level directories with read-only permissions for everyone
    for dirname in ['documents', 'tasks', 'solutions']:
        os.makedirs(dirname)
    setfacl('other', '', 'r--', 'documents')
    setfacl('other', '', 'r--', 'tasks')
    setfacl('other', '', 'r--', 'solutions')

    # add students to group
    group = UserGroup()
    for student in set(student_ids + [friend_id]):
        group.create_user(student)

    # setup group permissions for top-level directories
    setfacl('group', group.name, 'r-x', 'documents')
    setfacl('group', group.name, 'r--', 'documents', default=True)
    setfacl('group', group.name, 'r-x', 'tasks')
    setfacl('group', group.name, 'r--', 'tasks', default=True)
    setfacl('group', group.name, 'r-x', 'solutions')
    setfacl('group', group.name, 'r--', 'solutions', default=True)

    # create specific rules for a friend
    setfacl('user', friend_id, 'r-x', 'documents')
    setfacl('user', friend_id, 'rw-', 'documents', default=True)
    setfacl('user', friend_id, 'rwx', 'tasks')
    setfacl('user', friend_id, 'rwx', 'tasks', default=True)
    setfacl('user', friend_id, 'rwx', 'solutions')
    setfacl('user', friend_id, 'rwx', 'solutions', default=True)

    # create solutions subdirectories and set up individual permissions
    for student, task in product(student_ids, range(args.num_tasks)):
        solutions_dirname = os.path.join('solutions', f"{student}-{task}")
        os.makedirs(solutions_dirname)
        setfacl('user', student, 'rwx', solutions_dirname)
        setfacl('user', student, 'rwx', solutions_dirname, default=True)
        setfacl('other', '', 'r--', solutions_dirname)
