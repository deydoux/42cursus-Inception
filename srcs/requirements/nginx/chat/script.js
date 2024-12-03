function setModalTitle(title) {
	document.getElementById("modal-title").innerText = title;
}

function setModalInfo(info) {
	document.getElementById("modal-info").innerText = info;
}

function showModal(status) {
	document.getElementById("modal").style.display = status ? "flex" : "none";
}

function pullModel(modelName) {
	return (new Promise(async resolve => {
		setModalTitle(`Pulling ${modelName} model`);
		showModal(true);
		const body = JSON.stringify({ model: modelName });
		const response = await fetch("/ollama/api/pull", { method: "POST", body });
		const reader = response.body.getReader();
		const decoder = new TextDecoder();

		let success = false;
		while (true) {
			const { done, value } = await reader.read();
			if (done)
				break ;

			const datas = decoder.decode(value, { stream: true })
			.trim()
			.split('\n')
			.map(line => JSON.parse(line));
			for (const data of datas) {
				setModalInfo(data.status || `Error: ${data.error}`)
				console.log(data);
				if (data.status === "success")
					success = true;
			}
		}

		if (success)
			showModal(false);
		resolve(success);
	}));
}

function checkModel(modelName) {
	if (!modelName)
		return (false);

	return (new Promise(async resolve => {
		const response = await fetch("/ollama/api/tags");
		const data = await response.json();

		if (data.models.some(model => model.name == modelName))
			resolve(true);
		else
			resolve(await pullModel(modelName));
	}));
}

function getModelName() {
	const modelName = document.getElementById("model-input").value;
	if (!modelName.indexOf(':') < 0)
		modelName += ":latest";
	return (modelName);
}

async function generate() {
	const prompt = document.getElementById("prompt").value;
	if (!prompt)
		return ;

	const modelName = getModelName();
	if (!(await checkModel(modelName)))
		return ;
	console.log("Great")
}

document.getElementById("send-button").addEventListener("click", event => {
	event.preventDefault();
	generate();
})
