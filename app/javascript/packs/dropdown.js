window.filterFunction = filterFunction;
window.show = show;
window.search = search;

function filterFunction() {
    var input, filter, ul, li, a, i;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    div = document.getElementById("myDropdown");
    a = div.getElementsByTagName("li");
    for (i = 0; i < a.length; i++) {
      txtValue = a[i].textContent || a[i].innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        a[i].style.display = "";
      } else {
        a[i].style.display = "none";
      }
    }
}

function search(item){
  document.getElementById("myInput").value = item.innerText;
  console.log(item)
}

function show(){
  choices = document.getElementById("choices")
  choices.classList.toggle("hidden")
  
}
