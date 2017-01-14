show global status: (各个计数器的含义)
状态名	  			作用域	   		详细解释

Queries   			Both		    服务器执行的请求个数，包含存储过程中的请求。
Questions 			Both			已经发送给服务器的查询的个数。
注：both作用域表示既可以作用于全局，也可以作用于session
该两个字段可以用于统计QPS，计算公式：QPS = Questions(or Queries) / seconds 

Aborted_clients 	Global 			由于客户端没有正确关闭连接导致客户端终止而中断的连接数
Aborted_connects 	Global 			试图连接到MySQL服务器而失败的连接数
Connections 		Global 			试图连接到(不管是否成功)MySQL服务器的连接数
Max_used_connectionsGlobal 			服务器启动后已经同时使用的连接的最大数量。
Threads_connected	Global 			当前打开的连接的数量。
注：这些字段可以用于统计数据库连接的相关情况
检查下最大的过往使用连接数(Max_used_connections)，这个值在max_connections的85%左右是比较合适的，如果过高则是max_connections过少或者系统负荷过高了。

Handler_read_first 	Both 			索引中第一条被读的次数。如果较高，它建议服务器正执行大量全索引扫描；例如，SELECT col1 FROM foo， 假定col1有索引。
Handler_read_key 	Both 			根据键读一行的请求数。如果较高，说明查询和表的索引正确。
Handler_read_next 	Both 			按照键顺序读下一行的请求数。如果你用范围约束或如果执行索引扫描来查询索引列，该值增加。
Handler_read_prev 	Both 			按照键顺序读前一行的请求数。该读方法主要用于优化ORDER BY ... DESC。
Handler_read_rnd 	Both 			根据固定位置读一行的请求数。如果你正执行大量查询并需要对结果进行排序该值较高。你可能使用了大量需要MySQL扫 描整个表的查询或你的连接没有正确使用键。
Handler_read_rnd_next 	Both 		在数据文件中读下一行的请求数。如果你正进行大量的表扫描，该值较高。通常说明你的表索引不正确或写入的查询没有利用索引。
注：这些字段可以用于统计索引相关的情况
Handler_read_first
The number of times the first entry was read from an index. If this value is high, it suggests that the server is doing a lot of full index scans; 
for example,SELECT col1 FROM foo, assuming that col1 is indexed.
Handler_read_key(重点关注)
The number of requests to read a row based on a key. If this value is high, it is a good indication that your tables are properly indexed for your queries.
Handler_read_next
The number of requests to read the next row in key order. This value is incremented if you are querying an index column with a range constraint or if you are doing an index scan.
Handler_read_prev
The number of requests to read the previous row in key order. This read method is mainly used to optimize ORDER BY … DESC.
Handler_read_rnd
The number of requests to read a row based on a fixed position. This value is high if you are doing a lot of queries that require sorting of the result. 
You probably have a lot of queries that require MySQL to scan entire tables or you have joins that don’t use keys properly.
Handler_read_rnd_next(重点关注)
The number of requests to read the next row in the data file. This value is high if you are doing a lot of table scans. Generally this suggests that your tables are not properly indexed 
or that your queries are not written to take advantage of the indexes you have.

Com_commit							提交事务个数
Com_rollback						回滚事务个数
注：这些字段可以用于统计TPS，计算公式：TPS = (Com_commit + Com_rollback) / seconds 

Key_read_requests 	   Global 			从缓存读键(索引)的数据块的请求数。
Key_reads 			   Global 			从硬盘读取键(索引)的数据块的次数。如果Key_reads较大，则Key_buffer_size值可能太小。可以用Key_reads/Key_read_requests计算缓存损失率。
Key_write_requests 	   Global 			将键(索引)的数据块写入缓存的请求数。
Key_writes 			   Global 			向硬盘写入将键(索引)的数据块的物理写操作的次数。
注：该字段可以用来统计Key  buffer命中率，计算公式：
key_buffer_read_hits = (1-key_reads / key_read_requests) * 100% 
key_buffer_write_hits = (1-key_writes / key_write_requests) * 100%

Innodb_buffer_pool_reads 			Global 	不能满足InnoDB必须单页读取的缓冲池中的逻辑读数量。
Innodb_buffer_pool_read_requests 	Global 	InnoDB已经完成的逻辑读请求数。
注：这些字段可以用来统计InnoDB Buffer命中率，计算公式：innodb_buffer_read_hits = (1 - innodb_buffer_pool_reads / innodb_buffer_pool_read_requests) * 100% 
Innodb_buffer_pool_reads
The number of logical reads that InnoDB could not satisfy from the buffer pool, and had to read directlyfrom the disk.

Qcache_hits 			Global 	查询缓存被访问的次数。
Qcache_inserts 			Global 	加入到缓存的查询数量。
Qcache_free_blocks 		Global 	查询缓存内自由内存块的数量。
Qcache_free_memory 		Global 	用于查询缓存的自由内存的数量。
Qcache_lowmem_prunes 	Global 	由于内存较少从缓存删除的查询数量。
注：该字段可以用来统计Query Cache命中率，计算公式：Query_cache_hits = (Qcahce_hits / (Qcache_hits + Qcache_inserts )) * 100%; 
Com_select的值等价于Qcache_inserts+Qcache_not_cached+queries with errors found during columns/rights check.
也就是说com_select变量记录的是缓存失效查询次数(Qcache_inserts)+无缓存的查询次数(Qcache_not_cached)+错误查询
所以缓存命中率计算公式为：Query_cache_hits=(Qcache_hits/(Qcache_hits+Com_select))可能更合适一点。
可以通过Qcache_free_blocks来观察碎片，这个值反应了剩余的空闲块，如果这个值很多，但是Qcache_lowmem_prunes却不断增加，则说明碎片太多了。可以使用flush query cache整理碎片，
重新排序，但不会清空，清空命令是reset query cache。整理碎片期间，查询缓存无法被访问，可能导致服务器僵死一段时间，所以查询缓存不宜太大。
Qcache_free_memory:查询缓存的内存大小，通过这个参数可以很清晰的知道当前系统的查询内存是否够用，是多了，还是不够用，DBA可以根据实际情况做出调整。
Query Cache 如何处理子查询的？
这是我遇到的最为常见的一个问题。其实 Query Cache 是以客户端请求提交的 Query 为对象来处理的，只要客户端请求的是一个 Query，无论这个 Query 是一个简单的单表查询还是多表 Join，
亦或者是带有子查询的复杂 SQL，都被当作成一个 Query，不会被分拆成多个 Query 来进行 Cache。所以，存在子查询的复杂 Query 也只会产生一个Cache对象，子查询不会产生单独的Cache内容。
UNION[ALL] 类型的语句也同样如此。
Query Cache 是以 block 的方式存储的数据块吗？
不是，Query Cache 中缓存的内容仅仅只包含该 Query 所需要的结果数据，是结果集。当然，并不仅仅只是结果数据，还包含与该结果相关的其他信息，比如产生该 Cache 的客户端连接的字符集，
数据的字符集，客户端连接的 Default Database等。 
Query Cache 为什么效率会非常高，即使所有数据都可以 Cache 进内存的情况下，有些时候也不如使用 Query Cache 的效率高？
Query Cache 的查找，是在 MySQL 接受到客户端请求后在对 Query 进行权限验证之后，SQL 解析之前。也就是说，当 MySQL 接受到客户端的SQL后，仅仅只需要对其进行相应的权限验证后就会通过
Query Cache来查找结果，甚至都不需要经过 Optimizer 模块进行执行计划的分析优化，更不许要发生任何存储引擎的交互，减少了大量的磁盘 IO 和 CPU 运算，所以效率非常高。
客户端提交的 SQL 语句大小写对 Query Cache 有影响吗？
有，由于Query Cache 在内存中是以HASH 结构来进行映射，HASH算法基础就是组成SQL语句的字符，所以必须要整个 SQL 语句在字符级别完全一致，才能在Query Cache 中命中，即使多一个空格也不行。
一个 SQL 语句在 Query Cache 中的内容，在什么情况下会失效？
为了保证 Query Cache 中的内容与是实际数据绝对一致，当表中的数据有任何变化，包括新增，修改，删除等，都会使所有引用到该表的 SQL 的 Query Cache 失效。
为什么我的系统在开启了 Query Cache 之后整体性能反而下降了？
当开启了 Query Cache 之后，尤其是当我们的 query_cache_type 参数设置为 1 以后，MySQL 会对每个 SELECT 语句都进行 Query Cache 查找，查找操作虽然比较简单，但仍然也是要消耗一些CPU
运算资源的。而由于 Query Cache 的失效机制的特性，可能由于表上的数据变化比较频繁，大量的 Query Cache 频繁的被失效，所以 Query Cache 的命中率就可能比较低下。所以有些场景下，
Query Cache 不仅不能提高效率，反而可能造成负面影响。
打开Qcache对读和写都会带来额外的消耗：
a、读查询开始之前必须检查是否命中缓存。
b、如果读查询可以缓存，那么执行完之后会写入缓存。
c、当向某个表写入数据的时候，必须将这个表所有的缓存设置为失效，如果缓存空间很大，则消耗也会很大，可能使系统僵死一段时间，因为这个操作是靠全局锁操作来保护的。
对InnoDB表，当修改一个表时，设置了缓存失效，但是多版本特性会暂时将这修改对其他事务屏蔽，在这个事务提交之前，所有查询都无法使用缓存，直到这个事务被提交，
所以长时间的事务，会大大降低查询缓存的命中。
配置缓存需要设置两个字段：query_cache_type和query_cache_size，query_cache_type有3个值 0代表关闭查询缓存OFF，1代表开启ON，2（DEMAND）代表当sql语句中有SQL_CACHE关键词时才缓存。

Open_tables 	Both 	当前打开的表的数量。
Opened_tables 	Both 	已经打开的表的数量。如果Opened_tables较大，table_cache 值可能太小。
注：该字段主要用于open_table_cache字段调优
open_tables:是当前在缓存中打开表的数量。
opened_tables:是mysql自启动起，打开表的数量。
我们知道，假如没有缓存的话，那么mysql服务在每次执行一个语句的时候，都会先打开一个表。当sql语句执行完成后，则把这个表关掉。这就是opend_tables中的值。
而open_tables这个值，是mysql在使用缓存的情况下，存储在缓存中的表的个数。我们可以这样做实验：执行flush tables;这个命令是mysql用来刷新缓存的。
当这个命令执行后，我们会看到open_tables这个值被清零了。但是opened_tables这个值还是保持原来值不变。
但是当我们关闭mysql服务，再重启后，opened_tables这个值也被清零了。由此，得出上述两个值的结论。
这也就是为什么说当open_tables这个值接近于table_buffer这个值的时候，同时opened_tables的值在不断的增加，这个时候就要考虑增大table_buffer这个缓存值了。
解释如下：因为open_tables的值接近于table_buffer，说明分配的缓存已经被用完了。而opened_tables这个值又在高速增加，说明mysql在不断的打开表。也就说明缓存中并没有这些要打开的表。
所以说，缓存应该是要增加了。因为如果表在缓存中，那么打开表的时候这两个值是不会增加的。
可以通过show variables like '%table_open_cache%'；查看当前设置的table_buffer大小。

Threads_created 	Global 	创建用来处理连接的线程数。如果Threads_created较大，你可能要增加thread_cache_size值。 缓存访问率的计算方法Threads_created/Connections。
Connections 		Global 	试图连接到(不管是否成功)MySQL服务器的连接数
注：这；两个字段可以用来统计Thread Cache 命中率，计算公式：Thread_cache_hits = (1 - Threads_created / connections ) * 100% 

Table_locks_waited 		Global 	不能立即获得的表的锁的次数。如果该值较高，并且有性能问题，你应首先优化查询，然后拆分表或使用复制
Table_locks_immediate 	Global 	立即获得的表的锁的次数。
可以用Table_locks_waited/Table_locks_immediate如果这个比值比较大的话，说明表锁造成的阻塞比较严重

Created_tmp_disk_tables 	Both 	服务器执行语句时在硬盘上自动创建的临时表的数量
Created_tmp_tables 			Both 	服务器执行语句时自动创建的内存中的临时表的数量。如果Created_tmp_disk_tables较大，你可能要增加tmp_table_size值使临时表基于内存而不基于硬盘
注：这两个字段可以用来统计临时表的状况。
Created_tmp_disk_tables/Created_tmp_tables比值最好不要超过10%，如果Created_tmp_tables值比较大，可能是排序句子过多或者是连接句子不够优化，此时可以考虑增大tmp_table_size字段，但是
这只是指标之法，并不能从根本上解决这个问题。

