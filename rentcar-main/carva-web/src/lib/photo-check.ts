// On-device photo checks for the identity check (KYC), in the browser:
// turn the photo upright, shrink it (max 1600px JPEG) and look for the
// usual problems — blurry, too dark, glare — before anything is sent.

export interface PhotoResult {
  blob: Blob;
  url: string;
  sharp: boolean;
  dark: boolean;
  glare: boolean;
}

const MAX = 1600;

async function decode(file: File): Promise<ImageBitmap | HTMLImageElement> {
  try {
    return await createImageBitmap(file, { imageOrientation: "from-image" });
  } catch {
    const url = URL.createObjectURL(file);
    const img = new Image();
    img.src = url;
    await img.decode();
    URL.revokeObjectURL(url);
    return img;
  }
}

/** Shrinks, re-encodes (drops EXIF/GPS) and checks one photo. */
export async function preparePhoto(file: File, isDocument: boolean): Promise<PhotoResult> {
  const img = await decode(file);
  const w0 = "naturalWidth" in img ? img.naturalWidth : img.width;
  const h0 = "naturalHeight" in img ? img.naturalHeight : img.height;
  const scale = Math.min(1, MAX / Math.max(w0, h0));
  const w = Math.round(w0 * scale);
  const h = Math.round(h0 * scale);
  const canvas = document.createElement("canvas");
  canvas.width = w;
  canvas.height = h;
  const ctx = canvas.getContext("2d")!;
  ctx.drawImage(img, 0, 0, w, h);
  const blob: Blob = await new Promise((res, rej) =>
    canvas.toBlob((b) => (b ? res(b) : rej(new Error("encode"))), "image/jpeg", 0.85),
  );

  // Checks on a small grey copy.
  const sw = 320;
  const sh = Math.max(1, Math.round((h / w) * sw));
  const small = document.createElement("canvas");
  small.width = sw;
  small.height = sh;
  const sctx = small.getContext("2d", { willReadFrequently: true })!;
  sctx.drawImage(canvas, 0, 0, sw, sh);
  const px = sctx.getImageData(0, 0, sw, sh).data;
  const grey = new Float32Array(sw * sh);
  let sum = 0;
  let bright = 0;
  for (let i = 0; i < sw * sh; i++) {
    const g = 0.299 * px[i * 4] + 0.587 * px[i * 4 + 1] + 0.114 * px[i * 4 + 2];
    grey[i] = g;
    sum += g;
    if (g > 250) bright++;
  }
  // Variance of the Laplacian: low = blurry.
  let lsum = 0;
  let lsq = 0;
  let n = 0;
  for (let y = 1; y < sh - 1; y++) {
    for (let x = 1; x < sw - 1; x++) {
      const i = y * sw + x;
      const l = grey[i - 1] + grey[i + 1] + grey[i - sw] + grey[i + sw] - 4 * grey[i];
      lsum += l;
      lsq += l * l;
      n++;
    }
  }
  const mean = lsum / Math.max(1, n);
  const variance = lsq / Math.max(1, n) - mean * mean;

  return {
    blob,
    url: URL.createObjectURL(blob),
    sharp: variance > 40,
    dark: sum / (sw * sh) < 45,
    glare: isDocument && bright / (sw * sh) > 0.04,
  };
}
