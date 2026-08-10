// import { prisma } from '../config/prisma';

// import cron from 'node-cron';

// cron.schedule('0 3 * * *', () => {
//   cleanupOldRecentlyViewedCarsBatch();
// });

// const BATCH_SIZE = 100;

// async function cleanupOldRecentlyViewedCarsBatch() {
//   let processedUserIds = new Set<string>();
//   let hasMore = true;

//   while (hasMore) {
//     // Get a batch of userIds not yet processed
//     const userIdsBatch = await prisma.recentlyViewedCar.findMany({
//       select: { userId: true },
//       where: {
//         userId: { notIn: Array.from(processedUserIds) },
//       },
//       distinct: ['userId'],
//       take: BATCH_SIZE,
//     });

//     if (userIdsBatch.length === 0) {
//       hasMore = false;
//       break;
//     }

//     for (const { userId } of userIdsBatch) {
//       processedUserIds.add(userId);

//       // Delete views beyond the most recent 15
//       await prisma.$transaction(async (tx) => {
//         const oldViews = await tx.recentlyViewedCar.findMany({
//           where: { userId },
//           orderBy: { viewedAt: 'desc' },
//           skip: 15,
//         });

//         if (oldViews.length > 0) {
//           await tx.recentlyViewedCar.deleteMany({
//             where: {
//               id: { in: oldViews.map((v) => v.id) },
//             },
//           });
//         }
//       });
//     }
//   }
// }
