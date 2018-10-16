import random

from bsk_utils.common import run_cmd

def read_ids(list_file):
    student_ids = []
    with open(list_file, 'r') as students_list:
        for student_info in students_list:
            student_id = student_info.split(' ')[0]
            student_ids.append(student_id)
    return student_ids


def setfacl(type, id, permissions, path, default=False):
    acl_rule = f'{type}:{id}:{permissions}'
    if default:
        run_cmd('setfacl', '-d', '-m', acl_rule, path)
    else:
        run_cmd('setfacl', '-m', acl_rule, path)


class UserGroup():
    def __init__(self):
        self.name = 'students-' + str(random.getrandbits(32))
        run_cmd('groupadd', self.name)

    def create_user(self, user_id):
        run_cmd('useradd', '-G', self.name, user_id)