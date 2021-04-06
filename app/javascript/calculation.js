window.addEventListener('load', () => {
  const inputPrice = document.getElementById("item-price");
  const feePrice = document.getElementById("add-tax-price");
  const profitPrice = document.getElementById("profit");
  inputPrice.addEventListener("input", () => {
    const inputValue = inputPrice.value;
    fee=Math.floor(inputValue*0.1);
    profit=inputValue-fee;
    feePrice.innerHTML = fee;
    profitPrice.innerHTML = profit;
  })
});
