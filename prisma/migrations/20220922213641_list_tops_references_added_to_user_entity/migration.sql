-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "todayTopTaskId" INTEGER,
    "upnextTopTaskId" INTEGER,
    "backlogTopTaskId" INTEGER,
    CONSTRAINT "User_todayTopTaskId_fkey" FOREIGN KEY ("todayTopTaskId") REFERENCES "Task" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "User_upnextTopTaskId_fkey" FOREIGN KEY ("upnextTopTaskId") REFERENCES "Task" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "User_backlogTopTaskId_fkey" FOREIGN KEY ("backlogTopTaskId") REFERENCES "Task" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_User" ("createdAt", "email", "id", "updatedAt") SELECT "createdAt", "email", "id", "updatedAt" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
CREATE UNIQUE INDEX "User_todayTopTaskId_key" ON "User"("todayTopTaskId");
CREATE UNIQUE INDEX "User_upnextTopTaskId_key" ON "User"("upnextTopTaskId");
CREATE UNIQUE INDEX "User_backlogTopTaskId_key" ON "User"("backlogTopTaskId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
