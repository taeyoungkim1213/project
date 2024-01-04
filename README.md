# project1
# project DB
create table accompany_comment
(
    accompanyCommentNo      int auto_increment
        primary key,
    accompanyNo             int                      not null,
    accompanyCommentWriter  varchar(50)              not null,
    accompanyCommentContent varchar(500)             not null,
    accompanyCommentRegDate datetime default (now()) not null
)
    engine = InnoDB;

create table accompany_connection
(
    accompanyConnectionNo int auto_increment
        primary key,
    accompanyNo           int                         not null,
    accompanyTitle        varchar(255)                not null,
    accompanyWriter       varchar(50)                 not null,
    accompanyPickApyUser  varchar(50) default (now()) not null,
    accompanyYN           tinyint(1)  default 0       not null
)
    engine = InnoDB;

create table accompany_like
(
    accompanyLikeNo   int auto_increment
        primary key,
    accompanyNo       int         null,
    accompanyLikeUser varchar(50) null
)
    engine = InnoDB;

create table accompany_main
(
    accompanyNo            int auto_increment
        primary key,
    accompanyWriter        varchar(50)                        null,
    accompanyTitle         varchar(255)                       not null,
    accompanyImg           varchar(100)                       null,
    accompanyContent       text                               not null,
    accompanyRecruit       int      default 0                 null,
    accompanyTripStartDate date                               null,
    accompanyTripEndDate   date                               null,
    accompanyArea          varchar(100)                       null,
    accompanyRegDate       datetime default CURRENT_TIMESTAMP null,
    accompanyLikeCnt       int      default 0                 null,
    accompanyViewCnt       int      default 0                 null
)
    engine = InnoDB;

create table accompany_pick
(
    accompanyPickNo      int auto_increment
        primary key,
    accompanyNo          int                                not null,
    accompanyWriter      varchar(50)                        not null,
    accompanyPickApyUser varchar(50)                        not null,
    accompanyMessage     varchar(255)                       not null,
    accompanyApyDate     datetime default CURRENT_TIMESTAMP null,
    accompanyYN          tinyint(1)                         null
)
    engine = InnoDB;

create table board_table
(
    id               bigint auto_increment
        primary key,
    boardWriter      varchar(50)                        not null,
    boardPass        varchar(20)                        not null,
    boardTitle       text                               not null,
    boardContents    varchar(500)                       not null,
    boardCreatedTime datetime default CURRENT_TIMESTAMP null,
    boardHits        int      default 0                 null,
    mainImagePath    varchar(255)                       null,
    detailImagePath  text                               null,
    mainUnique       varchar(255)                       null,
    detailUnique     text                               null
)
    engine = InnoDB;

create table comment_table
(
    id                 bigint auto_increment
        primary key,
    commentWriter      varchar(50)                        null,
    commentContents    varchar(200)                       null,
    boardId            bigint                             null,
    commentCreatedTime datetime default CURRENT_TIMESTAMP null,
    constraint fk_comment_table
        foreign key (boardId) references tripteam.board_table (id)
            on delete cascade
)
    engine = InnoDB;

create table package_content
(
    packageContentNo int auto_increment
        primary key,
    packageType      varchar(50)  not null,
    packageId        varchar(50)  not null,
    packageImg       varchar(50)  null,
    packageTitle     varchar(250) not null,
    packageContent   varchar(250) not null
)
    engine = InnoDB;

create table package_info
(
    packageNo        int auto_increment
        primary key,
    packageType      varchar(50)                         not null,
    packageId        varchar(50)                         null,
    packageCategory  varchar(50)                         not null,
    packageLocation  varchar(50)                         not null,
    packageTheme     varchar(250)                        null,
    packageStartDate varchar(50)                         not null,
    packagePrice     varchar(50)                         not null,
    packageRegDate   timestamp default CURRENT_TIMESTAMP null,
    packageUpdate    datetime                            null
)
    engine = InnoDB;

create table reservation_payment
(
    reservationNo          int auto_increment
        primary key,
    packageNo              int         null,
    userId                 varchar(50) null,
    reservationName        varchar(50) not null,
    reservationGender      varchar(50) not null,
    reservationBirth       varchar(50) not null,
    reservationNationality varchar(50) not null,
    reservationPhone       varchar(50) not null,
    reservationEmail       varchar(50) not null,
    packageStartDate       varchar(50) null,
    packagePrice           int         null,
    reservationTotalPrice  int         null,
    reservationPayMethod   varchar(50) null,
    reservationPayDate     datetime    not null
)
    engine = InnoDB;

create table user
(
    userNo      int auto_increment
        primary key,
    userId      varchar(45)              not null,
    userPw      varchar(100)             not null,
    userName    varchar(45)              not null,
    userGender  varchar(45)              not null,
    userBirth   varchar(45)              not null,
    userPhoneNo varchar(100)             not null,
    userEmail   varchar(100)             not null,
    userRegDate datetime default (now()) null
)
    engine = InnoDB;

