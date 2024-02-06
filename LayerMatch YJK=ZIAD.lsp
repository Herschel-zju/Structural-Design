(defun c:layma(/ ss n k en endata layertype linetyp);������ˢͼ�㼰����, Version 1.1, Date 2021.12.12
  (setvar "cmdecho" 0);�رջ�������ٶ�
  (prompt "\n<��ѡ��Χ>")
  (setq ss (ssget));����ѡ��
  (setq n 0);��ʼ��ѭ�����
  (setq k 0);��ʼ���������
  (repeat (sslength ss)
    (setq en (ssname ss n));��ȡѡ�񼯵�n�����
    (setq endata (entget en));��ȡ���������б�
	(setq layertype (cdr (assoc 8 endata)));ȡ������ͼ�����ԣ�Ⱥ��8
    (setq linetype (cdr (assoc 6 endata)));ȡ�������������ԣ�Ⱥ��6
    (cond ((= layertype "�嶴����") (setq endata (subst (cons 8 "S-SLAB-HOLE") (assoc 8 endata) endata)) (setq k (1+ k)))
          ((= layertype "�ߴ��ע-��") (setq endata (subst (cons 8 "S-BEAM-TEXT") (assoc 8 endata) endata))
		                               (setq endata (subst (cons 7 "Standard") (assoc 7 endata) endata));�޸�������ʽ
		                               (setq endata (subst (cons 40 300) (assoc 40 endata) endata));�޸��ָ�
		                               (setq endata (subst (cons 41 0.7) (assoc 41 endata) endata));�޸����ֿ��ϵ��
									                 (setq k (1+ k))
		      )
	        ((= layertype "����") (setq endata (subst (cons 8 "S-BEAM-CO") (assoc 8 endata) endata))
		                            (if (= linetype "����") (setq endata (subst (cons 8 "S-BEAM") (assoc 8 endata) endata)));��Ϊ���ߣ����Ϊ"S-BEAM"ͼ��
									              (if (= linetype "����") (setq endata (subst (cons 6 "ByLayer") (assoc 6 endata) endata)));�޸���������Ϊ���
									              (setq k (1+ k))
		      )
          ((= layertype "��������") (setq endata (subst (cons 8 "S-BEAM") (assoc 8 endata) endata)) (setq k (1+ k)));YJK3.1.1��������������ͼ��
	        ((= layertype "��ǽ") (setq endata (subst (cons 8 "S-WALL") (assoc 8 endata) endata)) (setq k (1+ k)))
	        ((= layertype "����") (setq endata (subst (cons 8 "S-COLS") (assoc 8 endata) endata)) (setq k (1+ k)))
	        ((= layertype "����") (setq endata (subst (cons 8 "S-AXIS") (assoc 8 endata) endata)) (setq k (1+ k)))
	 );ƥ���Ӧͼ��
    (entmod endata)
    (setq n (1+ n))
   );ѭ������

  (princ (strcat "\n ����<"(itoa k)">���������, �򿪻���ָʾ:"))
  (setvar "cmdecho" 1);�򿪻���
  );END OF TEST

(prompt "\nLayer Match, designed by ssx.")
(prompt "\n���ó���������layma")
(prin1)
