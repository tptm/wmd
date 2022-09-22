/*
  Warnings:

  - You are about to drop the `Note` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Note";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Task" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "comment" TEXT,
    "status" INTEGER NOT NULL DEFAULT 0,
    "prevId" INTEGER,
    "list" INTEGER NOT NULL DEFAULT 0,
    "topSubtaskId" INTEGER,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Task_prevId_fkey" FOREIGN KEY ("prevId") REFERENCES "Task" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Task_topSubtaskId_fkey" FOREIGN KEY ("topSubtaskId") REFERENCES "SubTask" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Task_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "SubTask" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "comment" TEXT,
    "status" INTEGER NOT NULL,
    "prevId" INTEGER,
    CONSTRAINT "SubTask_prevId_fkey" FOREIGN KEY ("prevId") REFERENCES "SubTask" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Task_prevId_key" ON "Task"("prevId");

-- CreateIndex
CREATE UNIQUE INDEX "Task_topSubtaskId_key" ON "Task"("topSubtaskId");

-- CreateIndex
CREATE UNIQUE INDEX "SubTask_prevId_key" ON "SubTask"("prevId");
