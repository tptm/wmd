import type { User, Task } from "@prisma/client";

import { prisma } from "~/db.server";

export type { Task } from "@prisma/client";

export function getTask({
  id,
  userId,
}: Pick<Task, "id"> & {
  userId: User["id"];
}) {
  return prisma.task.findFirst({
    select: { id: true, title: true },
    where: { id, userId },
  });
}

export function getTaskListItems({ userId }: { userId: User["id"] }) {
  const result = prisma.$queryRaw<Task[]>`
    WITH RECURSIVE priority(prevId) AS (
      SELECT todayTopTaskId from User WHERE User.id=${userId}
      UNION
      SELECT Task.prevId FROM Task, priority
        WHERE priority.prevId=Task.id
        LIMIT 100
    )
    SELECT Task.* FROM priority, Task
      WHERE priority.prevId = Task.id;
  `;
  return result;
}
