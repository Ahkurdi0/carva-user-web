import type { Car } from "./types";

/** Rented right now: the server's flag, or rentedAt set with no end / an end still ahead. */
export function isRented(car: Pick<Car, "rented" | "rentedAt" | "rentedUntil">, now = Date.now()) {
  if (typeof car.rented === "boolean") return car.rented;
  if (!car.rentedAt) return false;
  return !car.rentedUntil || new Date(car.rentedUntil).getTime() > now;
}
