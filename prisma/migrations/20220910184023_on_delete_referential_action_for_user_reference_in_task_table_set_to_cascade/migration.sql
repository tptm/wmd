-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Task" (
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
    CONSTRAINT "Task_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Task" ("comment", "id", "list", "prevId", "status", "title", "topSubtaskId", "userId") SELECT "comment", "id", "list", "prevId", "status", "title", "topSubtaskId", "userId" FROM "Task";
DROP TABLE "Task";
ALTER TABLE "new_Task" RENAME TO "Task";
CREATE UNIQUE INDEX "Task_prevId_key" ON "Task"("prevId");
CREATE UNIQUE INDEX "Task_topSubtaskId_key" ON "Task"("topSubtaskId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
