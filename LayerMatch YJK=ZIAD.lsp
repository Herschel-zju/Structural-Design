(defun c:layma(/ ss n k en endata layertype linetyp);技术性刷图层及文字, Version 1.1, Date 2021.12.12
  (setvar "cmdecho" 0);关闭回显提高速度
  (prompt "\n<框选范围>")
  (setq ss (ssget));创建选择集
  (setq n 0);初始化循环标记
  (setq k 0);初始化计数标记
  (repeat (sslength ss)
    (setq en (ssname ss n));获取选择集第n项对象
    (setq endata (entget en));获取对象属性列表
	(setq layertype (cdr (assoc 8 endata)));取出对象图层属性，群码8
    (setq linetype (cdr (assoc 6 endata)));取出对象线型属性，群码6
    (cond ((= layertype "板洞边线") (setq endata (subst (cons 8 "S-SLAB-HOLE") (assoc 8 endata) endata)) (setq k (1+ k)))
          ((= layertype "尺寸标注-梁") (setq endata (subst (cons 8 "S-BEAM-TEXT") (assoc 8 endata) endata))
		                               (setq endata (subst (cons 7 "Standard") (assoc 7 endata) endata));修改文字样式
		                               (setq endata (subst (cons 40 300) (assoc 40 endata) endata));修改字高
		                               (setq endata (subst (cons 41 0.7) (assoc 41 endata) endata));修改文字宽度系数
									                 (setq k (1+ k))
		      )
	        ((= layertype "砼梁") (setq endata (subst (cons 8 "S-BEAM-CO") (assoc 8 endata) endata))
		                            (if (= linetype "虚线") (setq endata (subst (cons 8 "S-BEAM") (assoc 8 endata) endata)));若为虚线，则改为"S-BEAM"图层
									              (if (= linetype "虚线") (setq endata (subst (cons 6 "ByLayer") (assoc 6 endata) endata)));修改虚线线型为随层
									              (setq k (1+ k))
		      )
          ((= layertype "砼梁虚线") (setq endata (subst (cons 8 "S-BEAM") (assoc 8 endata) endata)) (setq k (1+ k)));YJK3.1.1更新区分梁虚线图层
	        ((= layertype "砼墙") (setq endata (subst (cons 8 "S-WALL") (assoc 8 endata) endata)) (setq k (1+ k)))
	        ((= layertype "砼柱") (setq endata (subst (cons 8 "S-COLS") (assoc 8 endata) endata)) (setq k (1+ k)))
	        ((= layertype "轴线") (setq endata (subst (cons 8 "S-AXIS") (assoc 8 endata) endata)) (setq k (1+ k)))
	 );匹配对应图层
    (entmod endata)
    (setq n (1+ n))
   );循环结束

  (princ (strcat "\n 共有<"(itoa k)">个对象更新, 打开回显指示:"))
  (setvar "cmdecho" 1);打开回显
  );END OF TEST

(prompt "\nLayer Match, designed by ssx.")
(prompt "\n调用程序请输入layma")
(prin1)
