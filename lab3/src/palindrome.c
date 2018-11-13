#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include <security/pam_appl.h>
#include <security/pam_misc.h>

static struct pam_conv login_conv = {
    misc_conv,
    NULL
};

char* buffer = NULL;

void exit_fail(const char *msg) {
    fputs(msg, stderr);
    if (buffer != NULL) free(buffer);
    exit(1);
}

/**
 * Checks if input row is a palindrome and prints appropriate message.
 * Modifies buffer and buf_alloc.
 * Returns 1 if a row contained a dot, 0 otherwise.
 */
int parse_row(char** buffer, size_t* buf_alloc) {
    int has_dot = 0;
    size_t buf_size = 0;
    int c = 0;
    while ((c = getc(stdin)) != (int)'\n') {
        if (buf_size == *buf_alloc) {
            (*buf_alloc) *= 2;
            *buffer = (char*)realloc(*buffer, (*buf_alloc) * sizeof(char));
            if (*buffer == NULL) exit_fail("Memory allocation failed\n");
        }
        assert(buf_size < (*buf_alloc));
        (*buffer)[buf_size] = (char)c;
        buf_size++;
        if ((char)c == '.') has_dot = 1;
    }
    for (size_t i = 0; i < buf_size/2; i++) {
        size_t j = buf_size - i - 1;
        if ((*buffer)[i] != (*buffer)[j]) {
            puts("Nie");
            return has_dot;
        }
    }
    puts("Tak");
    return has_dot;
}

int main() {
    // handle user login
    int retval;
    pam_handle_t* pamh = NULL;
    char *username = NULL;

    retval = pam_start("palindrome", username, &login_conv, &pamh);  // TODO: Custom config name
    if (pamh == NULL || retval != PAM_SUCCESS) exit_fail("Failed to perform pam_start\n");

    retval = pam_set_item(pamh, PAM_USER_PROMPT, "Kto to?:");
    if (retval != PAM_SUCCESS) exit_fail("pam_set_item");

    retval = pam_authenticate(pamh, 0);
    if (retval != PAM_SUCCESS) exit(2);  // unauthorized, this is not a failure

    retval = pam_acct_mgmt(pamh, 0);
    if (retval != PAM_SUCCESS) exit(2);  // unauthorized, this is not a failure

    pam_end(pamh, PAM_SUCCESS);

    // initial memory allocation
    size_t buf_alloc = 100;
    buffer = (char*)calloc(buf_alloc, sizeof(char));
    if (!buffer) exit_fail("Memory allocation failed\n");
    // process rows in search of palindromes
    int c;
    while((c = getc(stdin)) != EOF) {
        ungetc(c, stdin);
        int has_dot = parse_row(&buffer, &buf_alloc);
        if (has_dot) break;
    }
    free(buffer);
    return 0;
}
