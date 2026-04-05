document.addEventListener("DOMContentLoaded", function () {
    const burger = document.querySelector(".burger");
    const sidebar = document.getElementById("dropdownContent");
    const navbar = document.getElementById("navbar");

    burger.addEventListener("click", function (event) {
        event.stopPropagation();
        sidebar.classList.toggle("show");
    });

    document.addEventListener("click", function (event) {
        if (!navbar.contains(event.target)) {
            sidebar.classList.remove("show");
        }
    });

});

function filterTherapists(gender) {
    const btnFemale = document.getElementById('btnFemale');
    const btnMale = document.getElementById('btnMale');

    const femaleSection = document.querySelector('.female-section');
    const maleSection = document.querySelector('.male-section');

    if (gender === 'female') {
        btnFemale.classList.add('active');
        btnMale.classList.remove('active');

        femaleSection.style.display = 'block';
        maleSection.style.display = 'none';
    } else {
        btnMale.classList.add('active');
        btnFemale.classList.remove('active');

        femaleSection.style.display = 'none';
        maleSection.style.display = 'block';
    }
}