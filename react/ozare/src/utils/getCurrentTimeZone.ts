export function getCurrentTimezone() {
  const offsetInMinutes = new Date().getTimezoneOffset();
  const offsetInHours = offsetInMinutes / 60;
  const timezone = Math.abs(Math.round(offsetInHours));

  return Math.min(timezone, 7);
}
