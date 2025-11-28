-- Piwigo Database Cleanup Script
-- 清理所有 Piwigo 表以便重新安装

USE piwigo_shigure;

-- 禁用外键检查
SET FOREIGN_KEY_CHECKS = 0;

-- 删除所有 Piwigo 表
DROP TABLE IF EXISTS piwigo_activity;
DROP TABLE IF EXISTS piwigo_categories;
DROP TABLE IF EXISTS piwigo_comments;
DROP TABLE IF EXISTS piwigo_config;
DROP TABLE IF EXISTS piwigo_favorites;
DROP TABLE IF EXISTS piwigo_group_access;
DROP TABLE IF EXISTS piwigo_groups;
DROP TABLE IF EXISTS piwigo_history;
DROP TABLE IF EXISTS piwigo_image_category;
DROP TABLE IF EXISTS piwigo_images;
DROP TABLE IF EXISTS piwigo_languages;
DROP TABLE IF EXISTS piwigo_old_permalinks;
DROP TABLE IF EXISTS piwigo_plugins;
DROP TABLE IF EXISTS piwigo_rate;
DROP TABLE IF EXISTS piwigo_search;
DROP TABLE IF EXISTS piwigo_sessions;
DROP TABLE IF EXISTS piwigo_tags;
DROP TABLE IF EXISTS piwigo_user_access;
DROP TABLE IF EXISTS piwigo_user_cache;
DROP TABLE IF EXISTS piwigo_user_feed;
DROP TABLE IF EXISTS piwigo_user_group;
DROP TABLE IF EXISTS piwigo_user_infos;
DROP TABLE IF EXISTS piwigo_user_mail_notification;
DROP TABLE IF EXISTS piwigo_users;

-- 重新启用外键检查
SET FOREIGN_KEY_CHECKS = 1;

-- 验证清理结果
SELECT 'Cleanup completed. All piwigo_ tables have been dropped.' AS status;

