<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_db' );

/** MySQL database username */
define( 'DB_USER', 'wordpress_user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'fJ-6ram!EmoK%tK+K,Wu@7]&dQIO/A.T3@Wc(&~1Y#|NBvKB$j#7o[rIRi%Z.0LW' );
define( 'SECURE_AUTH_KEY',  'FV~>6t{8ymt$G/~UvmFN.bV$6AS+K}4-nY|+{e^G=7J0B-GgILD45/[XAN.2ttbP' );
define( 'LOGGED_IN_KEY',    '8^~deRoJ6^oO;yUo%QZLBawR=A|G{=g&+B85oQ]8TJ-S(S4p6-ZvT87r+| b`+*p' );
define( 'NONCE_KEY',        'c]><h*kE5t8|j:b0<T3C,Fq|Ny<J>Yl@<^M)y2J+2A#~sLPsf=M2WiGs=dj#T^]*' );
define( 'AUTH_SALT',        'q-9rhHMINtc!m~)fS@JI}.K>0 0(#Kl?@EGt6LJh?0.5^Y[)O~a67! P+QDOceIn' );
define( 'SECURE_AUTH_SALT', 'MXmP(4^7)Sc@|wFq%@T+l#nSJ=|C.:i^y9/zJ|^|S6Oz2{-D?1.TW!U|V]p6QPx}' );
define( 'LOGGED_IN_SALT',   'W/c-v_r gwa5N=&>|7n 5pAOcU^@md+Z~OzD6YVlc,bj`K4|{1-E;?U,OFiqhx`F' );
define( 'NONCE_SALT',       '%-IGldHDD2$xH}+_n$&T;bf=x;O4On;mrB_=(+]e+fbAzv6CIos+pJ+Qd4**S3E2' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
