let RippleHook = {
    mounted() {
        this.el.addEventListener("click", (e) => {
            const ripple = this.el.querySelector(".ripple");
            const rect = this.el.getBoundingClientRect();
            const x = e.clientX - rect.left - 46 / 2;
            const y = e.clientY - rect.top - 46 / 2;

            ripple.style.left = `${x}px`;
            ripple.style.top = `${y}px`;
            ripple.classList.add("show");

            setTimeout(() => {
                ripple.classList.remove("show");
            }, 100);
        });
    },
};

export default RippleHook;
