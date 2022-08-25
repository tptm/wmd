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
  return prisma.task.findMany({
    where: { userId },
    select: { id: true, title: true }
  });
}
