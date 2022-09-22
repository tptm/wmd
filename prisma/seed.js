const { PrismaClient } = require("@prisma/client");
const bcrypt = require("bcryptjs");

const prisma = new PrismaClient();

async function seed() {
  const email = "rachel@remix.run";

  // cleanup the existing database
  await prisma.user.delete({ where: { email: "rachel@remix.run"} }).catch((e) => {
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

  // const verbs = ['Do', 'Make', 'Paint', 'Buy', 'Say', 'Pick', 'Decide on'];
  // const nouns = ['Block', 'Stand', 'Guitar', 'Mind', 'Light', 'Phone', 'Ashley'];
  
  // let prevId = null;

  // for (let i = 0; i < 8; i++) {
  //   const task = await prisma.task.create({
  //     data: {
  //       title: `${verbs[Math.floor(Math.random() * 7)]} ${nouns[Math.floor(Math.random() * 7)]}`,
  //       prevId,
  //       userId: user.id,
  //     }
  //   })
  //   prevId = task.id;
  // }

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
