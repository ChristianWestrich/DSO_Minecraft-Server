#!/bin/sh
FLAGS="-Xmx${MEMORY_MAX} -Xms${MEMORY_MIN} -jar server.jar"

[ "$NOGUI" = "true" ] && FLAGS="${FLAGS} --nogui"

echo "eula=${EULA}" > /mc-server/eula.txt
echo "Starting Server..."
java $FLAGS