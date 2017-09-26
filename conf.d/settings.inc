<?php
$databases['default'] = array ('default' =>
  array (
    // Get database credentials from env
    'database' => getenv('MYSQL_DATABASE'),
    'username' => getenv('MYSQL_USERNAME'),
    'password' => getenv('MYSQL_PASSWORD'),
    'host'     => getenv('MYSQL_HOSTNAME'),
    'port'     => '',
    'driver'   => 'mysql',
    'prefix'   => '',
  ),
);

$conf['file_temporary_path'] = '/tmp';

$conf['memcache_stampede_semaphore'] = 3;
$conf['memcache_stampede_wait_limit'] = 1;
$conf['memcache_stampede_wait_time'] = 1;
$conf['memcache_key_prefix'] = getenv('MEMCACHE_PREFIX');
$conf['memcache_servers'] = array(
  getenv('MEMCACHE_ENDPOINT') => 'default'
);
