# argo-quicktunnel

**特点：完全使用临时 quicktunnel 并且使用订阅来自动获取最新的节点，全部是使用 trycloudflare.com 域名**

示例部署演示：https://rft8lt-3000.csb.app/host/sub

GitHub Copilot: 以下是根据给定的 `api.js` 代码生成的 API 文档，用作项目的 `README.md` 文件。

这些是 `http://localhost:3001/`(Arogo tunnel) 上可用的 API 路径：

- `/debug`：标准的 pprof 端点，用于性能分析。
- `/metrics`：从 cloudflared 进程报告广泛的 Prometheus 指标。
- `/healthcheck`：如果 cloudflared 正在运行，则返回标准的 200 OK。
- `/ready`：返回 cloudflared 是否与边缘连接并能够提供流量以及连接器 ID。
- `/quicktunnel`：快速隧道的 API 路径。
- `/config`：如果隧道由 Cloudflare 远程管理，则返回活动配置的 JSON。

以下是关于如何设置环境变量的文档介绍，以便正确运行 `api.js`。

## 环境变量

`UUID` 设置一个例子为 `91b985e2-7d7d-40e9-9a05-60423e51a632` 的 UUID。

- `UUID`：用于 vlees 的 UUID。

`api.js` 使用以下环境变量：

- `PORT`：指定应用程序监听的端口号。如果未设置，则默认为 `3000`。

要设置环境变量，请在终端中使用以下语法：

```
export VARIABLE_NAME=value
```

例如，要将端口号设置为 `8080`，请使用以下命令：

```
export PORT=8080
```

请注意，这将仅在当前终端会话中设置环境变量。如果您希望永久设置环境变量，请将其添加到您的 shell 配置文件中，例如 `~/.bashrc` 或 `~/.zshrc`。

## GET /

返回 `Hello World! quicktunnel hostname: ${data.hostname}`。

### 请求参数

无。

### 响应参数

| 参数名        | 类型   | 描述                   |
| ------------- | ------ | ---------------------- |
| data.hostname | string | quicktunnel 的主机名。 |

### 示例

请求：

```
GET /
```

响应：

```
Hello World! quicktunnel hostname: example.com
```

## GET /health

返回 `http://localhost:3001/healthcheck` 的响应。

### 请求参数

无。

### 响应参数

| 参数名 | 类型   | 描述                                         |
| ------ | ------ | -------------------------------------------- |
| data   | string | `http://localhost:3001/healthcheck` 的响应。 |

### 示例

请求：

```
GET /health
```

响应：

```
OK
```

## GET /host

返回 quicktunnel 的主机名。

### 请求参数

无。

### 响应参数

| 参数名        | 类型   | 描述                   |
| ------------- | ------ | ---------------------- |
| data.hostname | string | quicktunnel 的主机名。 |

### 示例

请求：

```
GET /host
```

响应：

```
example.com
```

## GET /host/sub

根据返回 quicktunnel 的主机名，来返回 quicktunnel vless 节点订阅信息。

### 请求参数

无。

### 响应参数

| 参数名        | 类型   | 描述                   |
| ------------- | ------ | ---------------------- |
| data.hostname | string | quicktunnel 的主机名。 |

### 示例

请求：

```
GET /host/sub
```

响应：

```
vless://91b985e2-7d7d-40e9-9a05-60423e51a632@lanes-slight-silicon-inclusive.trycloudflare.com:80?encryption=none&security=none&fp=random&type=ws&host=lanes-slight-silicon-inclusive.trycloudflare.com&path=%2F%3Fed%3D2048#lanes-slight-silicon-inclusive.trycloudflare.com-HTTP
vless://91b985e2-7d7d-40e9-9a05-60423e51a632@skk.moe:80?encryption=none&security=none&fp=random&type=ws&host=lanes-slight-silicon-inclusive.trycloudflare.com&path=%2F%3Fed%3D2048#lanes-slight-silicon-inclusive.trycloudflare.com-HTTP-skk.moe
```
