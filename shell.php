<?php
$cmd = 'ls -ld';
echo '<code style=display:block;white-space:pre-wrap>';
echo shell_exec($cmd);
echo '</code>';
?>
