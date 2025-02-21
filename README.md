# lima-config

Limaで使用する設定ファイルをまとめたレポジトリです。個人用。

## 使い方

レポジトリをクローンしなくてもURLを直接指定することができる。

```shell
limactl create --name default --cpus 4 --memory 8 https://raw.githubusercontent.com/y2aiskni/lima-config/refs/heads/main/default.yaml
```

```shell
limactl start default
```

```shell
limactl shell default
```
