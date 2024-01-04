# project1
# project DB
create table board_table
(
    boardId       int auto_increment
        primary key,
    boardWriter   varchar(100)                          not null,
    boardTitle    text                                  not null,
    boardContents text                                  not null,
    boardPrice    int         default 0                 not null,
    saleStatus    varchar(50) default '판매중'             not null,
    boardCreate   datetime    default CURRENT_TIMESTAMP null,
    boardHits     int         default 0                 null,
    boardFileName varchar(255)                          null,
    boardFileDB   varchar(255)                          null
);

create table member_table
(
    id             bigint auto_increment
        primary key,
    memberEmail    varchar(255) null,
    memberPassword varchar(20)  null,
    memberName     varchar(20)  null,
    memberAge      int          null,
    memberMobile   varchar(30)  null,
    constraint memberEmail
        unique (memberEmail)
);

create table board_like_table
(
    likeId    int auto_increment
        primary key,
    userEmail varchar(255) null,
    boardId   int          null,
    constraint board_like_table_ibfk_1
        foreign key (userEmail) references member_table (memberEmail),
    constraint board_like_table_ibfk_2
        foreign key (boardId) references board_table (boardId)
);

create index boardId
    on board_like_table (boardId);

create index userEmail
    on board_like_table (userEmail);

create table board_report_table
(
    reportId      int auto_increment
        primary key,
    userEmail     varchar(255) null,
    boardId       int          null,
    report_reason text         null,
    report_date   varchar(50)  null,
    constraint board_report_table_ibfk_1
        foreign key (userEmail) references member_table (memberEmail),
    constraint board_report_table_ibfk_2
        foreign key (boardId) references board_table (boardId)
);

create index boardId
    on board_report_table (boardId);

create index userEmail
    on board_report_table (userEmail);
