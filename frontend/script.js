async function get_visitors() {
    try {
        let response = await fetch('https://1b7tc3rdb1.execute-api.us-east-1.amazonaws.com/Prod', {
            method: 'GET',
        });
        let data = await response.json()
        document.getElementById("visitors").innerHTML = data['vist_count'];
        console.log(data);
        return data;
    } catch (err) {
        console.error(err);
    }
}


get_visitors();