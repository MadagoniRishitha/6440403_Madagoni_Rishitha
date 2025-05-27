// JavaScript content is same as before, omitted here for brevity
function countChars(el) {
    document.getElementById('confirmation').textContent = `Characters typed: ${el.value.length}`;
}

function showConfirmation(event) {
    event.preventDefault();
    document.getElementById('confirmation').textContent = "Form submitted successfully!";
}

function confirmSubmit() {
    alert("Thank you for your submission!");
}

function videoReady() {
    document.getElementById("videoStatus").textContent = "Video ready to play";
}

function findLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
                document.getElementById("location").textContent =
                    `Latitude: ${position.coords.latitude}, Longitude: ${position.coords.longitude}`;
            },
            (error) => {
                document.getElementById("location").textContent =
                    "Geolocation failed: " + error.message;
            },
            { enableHighAccuracy: true, timeout: 10000 }
        );
    } else {
        document.getElementById("location").textContent = "Geolocation not supported";
    }
}

function validatePhone(input) {
    const phoneRegex = /^[0-9]{10}$/;
    if (!phoneRegex.test(input.value)) {
        alert("Enter a valid 10-digit phone number.");
        input.focus();
    }
}

function savePreference() {
    const eventType = document.getElementById("eventType").value;
    localStorage.setItem("preferredEvent", eventType);
}

function clearPreferences() {
    localStorage.clear();
    sessionStorage.clear();
    alert("Preferences cleared.");
}

window.onload = () => {
    const savedEvent = localStorage.getItem("preferredEvent");
    if (savedEvent) {
        document.getElementById("eventType").value = savedEvent;
    }
}

window.onbeforeunload = () => {
    return "Are you sure you want to leave? Your data may not be saved.";
};
