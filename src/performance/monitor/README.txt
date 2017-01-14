show global status: (�����������ĺ���)
״̬��	  			������	   		��ϸ����

Queries   			Both		    ������ִ�е���������������洢�����е�����
Questions 			Both			�Ѿ����͸��������Ĳ�ѯ�ĸ�����
ע��both�������ʾ�ȿ���������ȫ�֣�Ҳ����������session
�������ֶο�������ͳ��QPS�����㹫ʽ��QPS = Questions(or Queries) / seconds 

Aborted_clients 	Global 			���ڿͻ���û����ȷ�ر����ӵ��¿ͻ�����ֹ���жϵ�������
Aborted_connects 	Global 			��ͼ���ӵ�MySQL��������ʧ�ܵ�������
Connections 		Global 			��ͼ���ӵ�(�����Ƿ�ɹ�)MySQL��������������
Max_used_connectionsGlobal 			�������������Ѿ�ͬʱʹ�õ����ӵ����������
Threads_connected	Global 			��ǰ�򿪵����ӵ�������
ע����Щ�ֶο�������ͳ�����ݿ����ӵ�������
��������Ĺ���ʹ��������(Max_used_connections)�����ֵ��max_connections��85%�����ǱȽϺ��ʵģ������������max_connections���ٻ���ϵͳ���ɹ����ˡ�

Handler_read_first 	Both 			�����е�һ�������Ĵ���������ϸߣ��������������ִ�д���ȫ����ɨ�裻���磬SELECT col1 FROM foo�� �ٶ�col1��������
Handler_read_key 	Both 			���ݼ���һ�е�������������ϸߣ�˵����ѯ�ͱ��������ȷ��
Handler_read_next 	Both 			���ռ�˳�����һ�е���������������÷�ΧԼ�������ִ������ɨ������ѯ�����У���ֵ���ӡ�
Handler_read_prev 	Both 			���ռ�˳���ǰһ�е����������ö�������Ҫ�����Ż�ORDER BY ... DESC��
Handler_read_rnd 	Both 			���ݹ̶�λ�ö�һ�е����������������ִ�д�����ѯ����Ҫ�Խ�����������ֵ�ϸߡ������ʹ���˴�����ҪMySQLɨ ��������Ĳ�ѯ���������û����ȷʹ�ü���
Handler_read_rnd_next 	Both 		�������ļ��ж���һ�е�������������������д����ı�ɨ�裬��ֵ�ϸߡ�ͨ��˵����ı���������ȷ��д��Ĳ�ѯû������������
ע����Щ�ֶο�������ͳ��������ص����
Handler_read_first
The number of times the first entry was read from an index. If this value is high, it suggests that the server is doing a lot of full index scans; 
for example,SELECT col1 FROM foo, assuming that col1 is indexed.
Handler_read_key(�ص��ע)
The number of requests to read a row based on a key. If this value is high, it is a good indication that your tables are properly indexed for your queries.
Handler_read_next
The number of requests to read the next row in key order. This value is incremented if you are querying an index column with a range constraint or if you are doing an index scan.
Handler_read_prev
The number of requests to read the previous row in key order. This read method is mainly used to optimize ORDER BY �� DESC.
Handler_read_rnd
The number of requests to read a row based on a fixed position. This value is high if you are doing a lot of queries that require sorting of the result. 
You probably have a lot of queries that require MySQL to scan entire tables or you have joins that don��t use keys properly.
Handler_read_rnd_next(�ص��ע)
The number of requests to read the next row in the data file. This value is high if you are doing a lot of table scans. Generally this suggests that your tables are not properly indexed 
or that your queries are not written to take advantage of the indexes you have.

Com_commit							�ύ�������
Com_rollback						�ع��������
ע����Щ�ֶο�������ͳ��TPS�����㹫ʽ��TPS = (Com_commit + Com_rollback) / seconds 

Key_read_requests 	   Global 			�ӻ������(����)�����ݿ����������
Key_reads 			   Global 			��Ӳ�̶�ȡ��(����)�����ݿ�Ĵ��������Key_reads�ϴ���Key_buffer_sizeֵ����̫С��������Key_reads/Key_read_requests���㻺����ʧ�ʡ�
Key_write_requests 	   Global 			����(����)�����ݿ�д�뻺�����������
Key_writes 			   Global 			��Ӳ��д�뽫��(����)�����ݿ������д�����Ĵ�����
ע�����ֶο�������ͳ��Key  buffer�����ʣ����㹫ʽ��
key_buffer_read_hits = (1-key_reads / key_read_requests) * 100% 
key_buffer_write_hits = (1-key_writes / key_write_requests) * 100%

Innodb_buffer_pool_reads 			Global 	��������InnoDB���뵥ҳ��ȡ�Ļ�����е��߼���������
Innodb_buffer_pool_read_requests 	Global 	InnoDB�Ѿ���ɵ��߼�����������
ע����Щ�ֶο�������ͳ��InnoDB Buffer�����ʣ����㹫ʽ��innodb_buffer_read_hits = (1 - innodb_buffer_pool_reads / innodb_buffer_pool_read_requests) * 100% 
Innodb_buffer_pool_reads
The number of logical reads that InnoDB could not satisfy from the buffer pool, and had to read directlyfrom the disk.

Qcache_hits 			Global 	��ѯ���汻���ʵĴ�����
Qcache_inserts 			Global 	���뵽����Ĳ�ѯ������
Qcache_free_blocks 		Global 	��ѯ�����������ڴ���������
Qcache_free_memory 		Global 	���ڲ�ѯ����������ڴ��������
Qcache_lowmem_prunes 	Global 	�����ڴ���ٴӻ���ɾ���Ĳ�ѯ������
ע�����ֶο�������ͳ��Query Cache�����ʣ����㹫ʽ��Query_cache_hits = (Qcahce_hits / (Qcache_hits + Qcache_inserts )) * 100%; 
Com_select��ֵ�ȼ���Qcache_inserts+Qcache_not_cached+queries with errors found during columns/rights check.
Ҳ����˵com_select������¼���ǻ���ʧЧ��ѯ����(Qcache_inserts)+�޻���Ĳ�ѯ����(Qcache_not_cached)+�����ѯ
���Ի��������ʼ��㹫ʽΪ��Query_cache_hits=(Qcache_hits/(Qcache_hits+Com_select))���ܸ�����һ�㡣
����ͨ��Qcache_free_blocks���۲���Ƭ�����ֵ��Ӧ��ʣ��Ŀ��п飬������ֵ�ܶ࣬����Qcache_lowmem_prunesȴ�������ӣ���˵����Ƭ̫���ˡ�����ʹ��flush query cache������Ƭ��
�������򣬵�������գ����������reset query cache��������Ƭ�ڼ䣬��ѯ�����޷������ʣ����ܵ��·���������һ��ʱ�䣬���Բ�ѯ���治��̫��
Qcache_free_memory:��ѯ������ڴ��С��ͨ������������Ժ�������֪����ǰϵͳ�Ĳ�ѯ�ڴ��Ƿ��ã��Ƕ��ˣ����ǲ����ã�DBA���Ը���ʵ���������������
Query Cache ��δ����Ӳ�ѯ�ģ�
��������������Ϊ������һ�����⡣��ʵ Query Cache ���Կͻ��������ύ�� Query Ϊ����������ģ�ֻҪ�ͻ����������һ�� Query��������� Query ��һ���򵥵ĵ����ѯ���Ƕ�� Join��
������Ǵ����Ӳ�ѯ�ĸ��� SQL������������һ�� Query�����ᱻ�ֲ�ɶ�� Query ������ Cache�����ԣ������Ӳ�ѯ�ĸ��� Query Ҳֻ�����һ��Cache�����Ӳ�ѯ�������������Cache���ݡ�
UNION[ALL] ���͵����Ҳͬ����ˡ�
Query Cache ���� block �ķ�ʽ�洢�����ݿ���
���ǣ�Query Cache �л�������ݽ���ֻ������ Query ����Ҫ�Ľ�����ݣ��ǽ��������Ȼ����������ֻ�ǽ�����ݣ���������ý����ص�������Ϣ����������� Cache �Ŀͻ������ӵ��ַ�����
���ݵ��ַ������ͻ������ӵ� Default Database�ȡ� 
Query Cache ΪʲôЧ�ʻ�ǳ��ߣ���ʹ�������ݶ����� Cache ���ڴ������£���Щʱ��Ҳ����ʹ�� Query Cache ��Ч�ʸߣ�
Query Cache �Ĳ��ң����� MySQL ���ܵ��ͻ���������ڶ� Query ����Ȩ����֤֮��SQL ����֮ǰ��Ҳ����˵���� MySQL ���ܵ��ͻ��˵�SQL�󣬽���ֻ��Ҫ���������Ӧ��Ȩ����֤��ͻ�ͨ��
Query Cache�����ҽ��������������Ҫ���� Optimizer ģ�����ִ�мƻ��ķ����Ż���������Ҫ�����κδ洢����Ľ����������˴����Ĵ��� IO �� CPU ���㣬����Ч�ʷǳ��ߡ�
�ͻ����ύ�� SQL ����Сд�� Query Cache ��Ӱ����
�У�����Query Cache ���ڴ�������HASH �ṹ������ӳ�䣬HASH�㷨�����������SQL�����ַ������Ա���Ҫ���� SQL ������ַ�������ȫһ�£�������Query Cache �����У���ʹ��һ���ո�Ҳ���С�
һ�� SQL ����� Query Cache �е����ݣ���ʲô����»�ʧЧ��
Ϊ�˱�֤ Query Cache �е���������ʵ�����ݾ���һ�£������е��������κα仯�������������޸ģ�ɾ���ȣ�����ʹ�������õ��ñ�� SQL �� Query Cache ʧЧ��
Ϊʲô�ҵ�ϵͳ�ڿ����� Query Cache ֮���������ܷ����½��ˣ�
�������� Query Cache ֮�������ǵ����ǵ� query_cache_type ��������Ϊ 1 �Ժ�MySQL ���ÿ�� SELECT ��䶼���� Query Cache ���ң����Ҳ�����Ȼ�Ƚϼ򵥣�����ȻҲ��Ҫ����һЩCPU
������Դ�ġ������� Query Cache ��ʧЧ���Ƶ����ԣ��������ڱ��ϵ����ݱ仯�Ƚ�Ƶ���������� Query Cache Ƶ���ı�ʧЧ������ Query Cache �������ʾͿ��ܱȽϵ��¡�������Щ�����£�
Query Cache �����������Ч�ʣ�����������ɸ���Ӱ�졣
��Qcache�Զ���д���������������ģ�
a������ѯ��ʼ֮ǰ�������Ƿ����л��档
b���������ѯ���Ի��棬��ôִ����֮���д�뻺�档
c������ĳ����д�����ݵ�ʱ�򣬱��뽫��������еĻ�������ΪʧЧ���������ռ�ܴ�������Ҳ��ܴ󣬿���ʹϵͳ����һ��ʱ�䣬��Ϊ��������ǿ�ȫ���������������ġ�
��InnoDB�����޸�һ����ʱ�������˻���ʧЧ�����Ƕ�汾���Ի���ʱ�����޸Ķ������������Σ�����������ύ֮ǰ�����в�ѯ���޷�ʹ�û��棬ֱ����������ύ��
���Գ�ʱ������񣬻��󽵵Ͳ�ѯ��������С�
���û�����Ҫ���������ֶΣ�query_cache_type��query_cache_size��query_cache_type��3��ֵ 0����رղ�ѯ����OFF��1������ON��2��DEMAND������sql�������SQL_CACHE�ؼ���ʱ�Ż��档

Open_tables 	Both 	��ǰ�򿪵ı��������
Opened_tables 	Both 	�Ѿ��򿪵ı�����������Opened_tables�ϴ�table_cache ֵ����̫С��
ע�����ֶ���Ҫ����open_table_cache�ֶε���
open_tables:�ǵ�ǰ�ڻ����д򿪱��������
opened_tables:��mysql�������𣬴򿪱��������
����֪��������û�л���Ļ�����ômysql������ÿ��ִ��һ������ʱ�򣬶����ȴ�һ������sql���ִ����ɺ���������ص��������opend_tables�е�ֵ��
��open_tables���ֵ����mysql��ʹ�û��������£��洢�ڻ����еı�ĸ��������ǿ���������ʵ�飺ִ��flush tables;���������mysql����ˢ�»���ġ�
���������ִ�к����ǻῴ��open_tables���ֵ�������ˡ�����opened_tables���ֵ���Ǳ���ԭ��ֵ���䡣
���ǵ����ǹر�mysql������������opened_tables���ֵҲ�������ˡ��ɴˣ��ó���������ֵ�Ľ��ۡ�
��Ҳ����Ϊʲô˵��open_tables���ֵ�ӽ���table_buffer���ֵ��ʱ��ͬʱopened_tables��ֵ�ڲ��ϵ����ӣ����ʱ���Ҫ��������table_buffer�������ֵ�ˡ�
�������£���Ϊopen_tables��ֵ�ӽ���table_buffer��˵������Ļ����Ѿ��������ˡ���opened_tables���ֵ���ڸ������ӣ�˵��mysql�ڲ��ϵĴ򿪱�Ҳ��˵�������в�û����ЩҪ�򿪵ı�
����˵������Ӧ����Ҫ�����ˡ���Ϊ������ڻ����У���ô�򿪱��ʱ��������ֵ�ǲ������ӵġ�
����ͨ��show variables like '%table_open_cache%'���鿴��ǰ���õ�table_buffer��С��

Threads_created 	Global 	���������������ӵ��߳��������Threads_created�ϴ������Ҫ����thread_cache_sizeֵ�� ��������ʵļ��㷽��Threads_created/Connections��
Connections 		Global 	��ͼ���ӵ�(�����Ƿ�ɹ�)MySQL��������������
ע���⣻�����ֶο�������ͳ��Thread Cache �����ʣ����㹫ʽ��Thread_cache_hits = (1 - Threads_created / connections ) * 100% 

Table_locks_waited 		Global 	����������õı�����Ĵ����������ֵ�ϸߣ��������������⣬��Ӧ�����Ż���ѯ��Ȼ���ֱ��ʹ�ø���
Table_locks_immediate 	Global 	������õı�����Ĵ�����
������Table_locks_waited/Table_locks_immediate��������ֵ�Ƚϴ�Ļ���˵��������ɵ������Ƚ�����

Created_tmp_disk_tables 	Both 	������ִ�����ʱ��Ӳ�����Զ���������ʱ�������
Created_tmp_tables 			Both 	������ִ�����ʱ�Զ��������ڴ��е���ʱ������������Created_tmp_disk_tables�ϴ������Ҫ����tmp_table_sizeֵʹ��ʱ������ڴ��������Ӳ��
ע���������ֶο�������ͳ����ʱ���״����
Created_tmp_disk_tables/Created_tmp_tables��ֵ��ò�Ҫ����10%�����Created_tmp_tablesֵ�Ƚϴ󣬿�����������ӹ�����������Ӿ��Ӳ����Ż�����ʱ���Կ�������tmp_table_size�ֶΣ�����
��ֻ��ָ��֮���������ܴӸ����Ͻ��������⡣

