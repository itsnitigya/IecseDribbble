CREATE TABLE `users` (
	`userID` INT(11) NOT NULL AUTO_INCREMENT,
	`username` varchar(255) NOT NULL,
	`email` varchar(255) NOT NULL,
	`password` varchar(255) NOT NULL,
	`profileURL` varchar(255) NOT NULL,
	PRIMARY KEY (`userID`)
);

CREATE TABLE `posts` (
	`postID` varchar(255) NOT NULL,
	`userID` INT(11) NOT NULL,
	`postURL` varchar(255) NOT NULL,
	`title` varchar(255) NOT NULL,
	`username` varchar(255) NOT NULL,
	`profileURL` varchar(255) NOT NULL,
	`loveCount` INT(11) NOT NULL,
	`commentCount` INT(11) NOT NULL,
	PRIMARY KEY (`postID`)
);

CREATE TABLE `votes` (
	`love` BINARY NOT NULL,
	`postID` varchar(255) NOT NULL,
	`userID` varchar(255) NOT NULL,
	PRIMARY KEY (`postID`,`userID`)
);

CREATE TABLE `comments` (
	`commentID` varchar(255) NOT NULL AUTO_INCREMENT,
	`userID` INT(11) NOT NULL,
	`parentCommentID` varchar(255) NOT NULL,
	`postID` varchar(255) NOT NULL,
	`body` varchar(255) NOT NULL,
	`createdAt` TIMESTAMP NOT NULL,
	`mentions` varchar(255) NOT NULL,
	PRIMARY KEY (`commentID`)
);

ALTER TABLE `posts` ADD CONSTRAINT `posts_fk0` FOREIGN KEY (`userID`) REFERENCES `users`(`userID`);

ALTER TABLE `posts` ADD CONSTRAINT `posts_fk1` FOREIGN KEY (`postURL`) REFERENCES `users`(`userID`);

ALTER TABLE `posts` ADD CONSTRAINT `posts_fk2` FOREIGN KEY (`username`) REFERENCES `users`(`username`);

ALTER TABLE `posts` ADD CONSTRAINT `posts_fk3` FOREIGN KEY (`profileURL`) REFERENCES `users`(`profileURL`);

ALTER TABLE `votes` ADD CONSTRAINT `votes_fk0` FOREIGN KEY (`postID`) REFERENCES `posts`(`postID`);

ALTER TABLE `votes` ADD CONSTRAINT `votes_fk1` FOREIGN KEY (`userID`) REFERENCES `users`(`userID`);

ALTER TABLE `comments` ADD CONSTRAINT `comments_fk0` FOREIGN KEY (`userID`) REFERENCES `users`(`userID`);

ALTER TABLE `comments` ADD CONSTRAINT `comments_fk1` FOREIGN KEY (`postID`) REFERENCES `posts`(`postID`);

