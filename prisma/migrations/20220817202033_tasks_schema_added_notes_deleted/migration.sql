/*
  Warnings:

  - You are about to drop the `Note` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Note";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "UserState" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" TEXT NOT NULL,
    "dayTopId" INTEGER,
    "weekTopId" INTEGER,
    "backlogTopId" INTEGER,
    CONSTRAINT "UserState_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "UserState_dayTopId_fkey" FOREIGN KEY ("dayTopId") REFERENCES "Task" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "UserState_weekTopId_fkey" FOREIGN KEY ("weekTopId") REFERENCES "Task" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "UserState_backlogTopId_fkey" FOREIGN KEY ("backlogTopId") REFERENCES "Task" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Task" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "comment" TEXT,
    "status" TEXT NOT NULL,
    "upstackId" INTEGER,
    "topSubtaskId" INTEGER,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Task_upstackId_fkey" FOREIGN KEY ("upstackId") REFERENCES "Task" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Task_topSubtaskId_fkey" FOREIGN KEY ("topSubtaskId") REFERENCES "SubTask" ("id") ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT "Task_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "SubTask" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "comment" TEXT,
    "status" TEXT NOT NULL,
    "upstackId" INTEGER,
    CONSTRAINT "SubTask_upstackId_fkey" FOREIGN KEY ("upstackId") REFERENCES "SubTask" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "UserState_userId_key" ON "UserState"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserState_dayTopId_key" ON "UserState"("dayTopId");

-- CreateIndex
CREATE UNIQUE INDEX "UserState_weekTopId_key" ON "UserState"("weekTopId");

-- CreateIndex
CREATE UNIQUE INDEX "UserState_backlogTopId_key" ON "UserState"("backlogTopId");

-- CreateIndex
CREATE UNIQUE INDEX "Task_upstackId_key" ON "Task"("upstackId");

-- CreateIndex
CREATE UNIQUE INDEX "Task_topSubtaskId_key" ON "Task"("topSubtaskId");

-- CreateIndex
CREATE UNIQUE INDEX "SubTask_upstackId_key" ON "SubTask"("upstackId");
