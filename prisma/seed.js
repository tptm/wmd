const { PrismaClient } = require("@prisma/client");
const bcrypt = require("bcryptjs");

const prisma = new PrismaClient();

async function seed() {
  const email = "rachel@remix.run";

  // cleanup the existing database
  await prisma.user.delete({ where: { email } }).catch(() => {
    // no worries if it doesn't exist yet
  });

  const hashedPassword = await bcrypt.hash("racheliscool", 10);

  const user = await prisma.user.create({
    data: {
      email,
      password: {
        create: {
          hash: hashedPassword,
        },
      },
    },
  });

  const email2 = "roman@remix.run";

  await prisma.user.delete({ where: { email: email2 } }).catch(() => {
    // no worries if it doesn't exist yet
  });

  await prisma.user.create({
    data: {
      email: email2,
      password: {
        create: {
          hash: await bcrypt.hash("romaniscool", 10)
        },
      },
    },
  });

  const tasks = [
    {
      id: 1,
      title: "Task 1",
      status: "-",
      userId: user.id
    },
    {
      id: 2,
      upstackId: 1,
      title: "Task 2",
      status: "-",
      userId: user.id
    },
    {
      id: 3,
      upstackId: 2,
      title: "Task 3",
      status: "-",
      userId: user.id
    },
    {
      id: 4,
      upstackId: 3,
      title: "Task 4",
      status: "-",
      userId: user.id
    }
  ];

  for (const task of tasks) {
    await prisma.task.upsert({
      where: { id: task.id },
      update: task,
      create: task,
    });
  }


  console.log(`Database has been seeded. 🌱`);
}

seed()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
