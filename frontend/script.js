async function get_visitors() {
    try {
        let response = await fetch('https://cec4xjsouc.execute-api.us-east-1.amazonaws.com/Prod/counter', {
            method: 'GET',
        });
        let data = await response.json()
        document.getElementById("visitors").innerHTML = data['visit_count'];
        console.log(data);
        return data;
    } catch (err) {
        console.error(err);
    }
}


get_visitors();