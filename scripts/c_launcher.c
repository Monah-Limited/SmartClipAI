#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    char resources_path[4096];
    char *p = strstr(argv[0], "/MacOS/");
    if (p) {
        size_t prefix_len = p - argv[0];
        memcpy(resources_path, argv[0], prefix_len);
        strcpy(resources_path + prefix_len, "/Resources");
        chdir(resources_path);
    }

    const char *home = getenv("HOME");
    const char *paths[] = {
        "/opt/homebrew/bin/python3.11",
        "/opt/homebrew/bin/python3.12",
        "/usr/local/bin/python3.11",
        "/opt/homebrew/bin/python3",
        "/usr/bin/python3",
        NULL
    };
    for (int i = 0; paths[i]; i++) {
        if (access(paths[i], X_OK) == 0) {
            execl(paths[i], paths[i], "main_script.py", (char *)NULL);
        }
    }
    if (home) {
        char buf[4096];
        snprintf(buf, sizeof(buf), "%s/.hermes/hermes-agent/venv/bin/python3", home);
        if (access(buf, X_OK) == 0)
            execl(buf, buf, "main_script.py", (char *)NULL);
    }
    execl("/usr/bin/python3", "python3", "main_script.py", (char *)NULL);
    return 1;
}
