SELECT Id, image64
FROM [dbo].[tblSignedImages]
	 CROSS APPLY (SELECT signedImage AS '*' FOR XML PATH('')) T (image64)
WHERE WebSubmitID = 2068

/*decode base64*/
SELECT 
    CONVERT
    (
        VARCHAR(MAX), 
        CAST('' AS XML).VALUE('xs:base64Binary(sql:column("BASE64_COLUMN"))', 'VARBINARY(MAX)')
    ) AS RESULT
FROM
    (
        SELECT Id, BASE64_COLUMN 
		FROM [dbo].[tblSignedImages]
			 CROSS APPLY (SELECT signedImage AS '*' FOR XML PATH('')) T (BASE64_COLUMN)
		WHERE WebSubmitID = 2068
    ) A