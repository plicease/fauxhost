#include <stdlib.h>
#include <string.h>

int
gethostname(char *name, size_t len)
{
  char *fauxhostname = getenv("FAUXHOSTNAME");
  if(fauxhostname == NULL)
    fauxhostname = "faux";
  strncpy(name, fauxhostname, len);
  return 0;
}
