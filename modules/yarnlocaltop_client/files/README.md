Usage notes:

    1. You will need to run yarnlocaltop with the same user/group as the running process. On non-secure clusters this will usually be the yarn user.
    2. You should set JAVA_HOME to your JDK path before running. Not having JAVA_HOME set will lead to an error about missing JDK.
    3. If you get the message "java.io.IOException: well-known file is not secure" you need to change your group membership to the appropriate group using newgrp. Example: "newgrp yarn".
