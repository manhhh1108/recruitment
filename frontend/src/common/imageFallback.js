export const logoFallback = process.env.PUBLIC_URL + "/logo192.png";
export const bannerFallback = process.env.PUBLIC_URL + "/image/poster4.jpg";

export const useLogoFallback = (event) => {
  event.currentTarget.onerror = null;
  event.currentTarget.src = logoFallback;
};

export const useBannerFallback = (event) => {
  event.currentTarget.onerror = null;
  event.currentTarget.src = bannerFallback;
};
