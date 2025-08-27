# MyBatis Mapper XML Files

这个目录包含MyBatis的XML映射器文件。

## 文件命名约定

- `UserMapper.xml` - 用户相关数据操作
- `CategoryMapper.xml` - 分类相关数据操作
- `TransactionMapper.xml` - 交易记录相关数据操作
- `ExchangeRateMapper.xml` - 汇率相关数据操作

## 注意事项

1. XML文件名应与对应的Mapper接口名保持一致
2. namespace应指向对应的Mapper接口全限定名
3. SQL语句应使用参数化查询防止SQL注入